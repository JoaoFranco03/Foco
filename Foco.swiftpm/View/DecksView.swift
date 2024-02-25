//
//  FlashCardsView.swift
//  Foco
//
//  Created by João Franco on 11/02/2024.
//

import SwiftUI

struct DecksView: View {
    //Environment Variables
    @Environment(\.colorScheme) var colorScheme
    
    //Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    @EnvironmentObject var classesController: ClassesController
    
    //Sheets
    @State private var showingNewFlashCardDeckSheet = false
    
    //BG Gradient
    var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 74/255, green: 42/255, blue: 124/255),
                Color(red: 21/255, green: 6/255, blue: 40/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ) :
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 255/255, green: 254/255, blue: 253/255),
                Color(red: 150/255, green: 114/255, blue: 195/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                backgroundGradient
                    .ignoresSafeArea()
                VStack{
                    if flashCardsDeckController.decks.isEmpty{
                        if #available(iOS 17.0, *) {
                            ContentUnavailableView {
                                Label("No Decks have been made", systemImage: "rectangle.on.rectangle.angled")
                            } description: {
                                Text("Create your first deck to get started.")
                            } actions: {
                                Button("Add new deck") {
                                    showingNewFlashCardDeckSheet.toggle()
                                }
                                .tint(Color(red: 169/255, green: 131/255, blue: 255/255))
                                .buttonStyle(.borderedProminent)
                            }
                        } else {
                            Text("Please add a new Class")
                        }
                    } else {
                        VStack {
                            ScrollView{
                                ForEach(flashCardsDeckController.decks) { deck in
                                    let color: Color? = {
                                        guard let classID = deck.classID,
                                              let classItem = classesController.getClassesByID(classID: classID) else {
                                            return nil
                                        }
                                        return classesController.stringToColor(colorString: classItem.color) ?? .white
                                    }()
                                    NavigationLink(destination: FlashCardsDeckDetailView(deck: deck, color: color ?? Color.white)) {
                                        DeckView(deck: deck)
                                    }
                                }
                                .padding(.bottom, 80)
                            }
                            .padding(.horizontal)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Decks")
            .toolbar {
                //AddDeck
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingNewFlashCardDeckSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(red: 169/255, green: 131/255, blue: 255/255))
                    }
                    .popover(isPresented: $showingNewFlashCardDeckSheet) {
                        AddDeckSheet()
                            .frame(minWidth: 400, minHeight: 195)
                    }
                }
            }
        }
    }
}

#Preview {
    DecksView()
}

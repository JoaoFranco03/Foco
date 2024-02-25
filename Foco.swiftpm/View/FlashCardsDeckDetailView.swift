//
//  FlashCardsDeckDetailView.swift
//  Foco
//
//  Created by João Franco on 17/02/2024.
//

import SwiftUI

struct FlashCardsDeckDetailView: View {
    //Environment
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    //Deck
    var deck: FlashCardsDeck
    var color:Color
    
    //Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    
    //Sheets
    @State private var showingAddFlashCardToDeck = false
    @State private var showingEditDeck = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [color.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                if deck.flashCards.isEmpty {
                    if #available(iOS 17.0, *) {
                        ContentUnavailableView {
                            Label("No Flash Cards Yet", systemImage: "rectangle")
                        } description: {
                            Text("Create your first flash card to get started.")
                        } actions: {
                            // 2
                            Button("Add new flash card") {
                                showingAddFlashCardToDeck.toggle()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(color.opacity(0.5))
                        }
                    } else {
                        Text("Please add a new Flash Card")
                    }
                } else {
                    ScrollView {
                        VStack{
                            if horizontalSizeClass == .compact {
                                ForEach(deck.flashCards) { card in
                                    FlashCardView(deck: deck, card: card)
                                }
                                .padding(.horizontal)
                            }  else {
                                LazyVGrid(columns: Array(repeating: .init(.flexible()),count: UIDevice.current.userInterfaceIdiom == .pad ? 3 : 1)){
                                    ForEach(deck.flashCards) { card in
                                        FlashCardView(deck: deck, card: card)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 80)
                    }
                }
            }
        }
        .navigationTitle(deck.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            //Edit Button
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingEditDeck.toggle()
                } label: {
                    Image(systemName: "pencil")
                }
                .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                .foregroundStyle(color)
            }
            //Delete Button
            ToolbarItem(placement: .primaryAction) {
                Button {
                    flashCardsDeckController.deleteDeck(id: deck.id)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "trash.fill")
                }
                .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                .foregroundStyle(color)
            }
            //Add Button
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddFlashCardToDeck.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                .foregroundStyle(color)
            }
        }
        //Add Sheet
        .sheet(isPresented: $showingAddFlashCardToDeck) {
            AddFlashCardToDeckSheet(deck: deck)
        }
        //Edit Sheet
        .sheet(isPresented: $showingEditDeck) {
            EditDeckSheet(deck: deck)
        }
    }
}

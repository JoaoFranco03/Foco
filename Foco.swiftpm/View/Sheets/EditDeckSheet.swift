//
//  EditDeckSheet.swift
//
//
//  Created by João Franco on 24/02/2024.
//

import SwiftUI

struct EditDeckSheet: View {
    //Environment Variables
    @Environment(\.dismiss) var dismiss
    
    //Inputs Variables
    var deck: FlashCardsDeck
    @State private var name: String = ""
    @State private var selectedClass: ClassItem?
    
    //Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    @EnvironmentObject var classesController: ClassesController
    
    //Set Inputs to Deck Attributes
    init(deck: FlashCardsDeck) {
        self.deck = deck
        _name = State(initialValue: deck.name)
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(header: Text("Deck Details")) {
                        //Deck Name
                        LabeledContent {
                            TextField("Name", text: $name)
                                .multilineTextAlignment(.trailing)
                        } label: {
                            Text("Name")
                        }
                        
                        //Deck Class
                        Picker("Class", selection: $selectedClass) {
                            Text("None").tag(nil as ClassItem?)
                            ForEach(classesController.classes) { classItem in
                                Text(classItem.name).tag(classItem as ClassItem?)
                            }
                        }
                        //Update the selectedClass at Start
                        .onAppear {
                            if let classID = deck.classID,
                               let classItem = classesController.getClassesByID(classID: classID) {
                                selectedClass = classItem
                            } else {
                                selectedClass = nil
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit New Deck")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                //Dismiss Sheet
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(red: 169/255, green: 131/255, blue: 255/255))
                    })
                }
                
                //Edit Deck to decks
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        if let classID = selectedClass?.id {
                            flashCardsDeckController.editDeck(deckID: deck.id, newName: name, classID: classID)
                        } else {
                            flashCardsDeckController.editDeck(deckID: deck.id, newName: name, classID: UUID())
                        }
                        dismiss()
                    }, label: {
                        Text("Edit")
                            .bold()
                            .foregroundStyle(name.isEmpty ? .gray : Color(red: 169/255, green: 131/255, blue: 255/255))
                    }).disabled(name.isEmpty)
                }
            })
        }
    }
}


//
//  AddDeckSheet.swift
//
//
//  Created by João Franco on 17/02/2024.
//

import Foundation
import SwiftUI

struct AddDeckSheet: View {
    
    //Sheet Variables
    @Environment(\.dismiss) var dismiss
    
    //Inputs Variables
    @State private var name: String = ""
    @State private var selectedClass: ClassItem?

    //Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    @EnvironmentObject var classesController: ClassesController
    
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
                    }
                }
            }
            .navigationTitle("Add New Deck")
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
                
                //Add Deck to decks
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        if selectedClass == nil{
                            flashCardsDeckController.addDeck(name: name)
                        } else {
                            flashCardsDeckController.addDeck(name: name, classID: selectedClass!.id)
                        }
                        dismiss()
                    }, label: {
                        Text("Add")
                            .bold()
                            .foregroundStyle(name.isEmpty ? .gray : Color(red: 169/255, green: 131/255, blue: 255/255))
                    }).disabled(name.isEmpty)
                }
            })
        }
    }
}

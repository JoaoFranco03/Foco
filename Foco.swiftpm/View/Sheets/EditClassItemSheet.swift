//
//  EditClassItemSheet.swift
//
//
//  Created by João Franco on 24/02/2024.
//

import SwiftUI

struct EditClassItemSheet: View {
    
    //Sheet Variables
    @Environment(\.dismiss) var dismiss
    @State private var showingEmojiPicker = false
    
    //Inputs Variables
    var classItem: ClassItem
    @State private var name: String = ""
    @State private var selectedColor: Color = Color.white
    @State private var emoji: String = ""
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController

    //Set Inputs to Class Attributes
    init(classItem: ClassItem) {
        self.classItem = classItem
        _name = State(initialValue: classItem.name)
        _emoji = State(initialValue: classItem.emoji)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Class Details")) {
                    
                    //Class Name
                    LabeledContent {
                        TextField("Name", text: $name)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("Name")
                    }

                    // Class Emoji
                    LabeledContent {
                        Button(action: {
                            showingEmojiPicker.toggle()
                        }) {
                            Text(emoji)
                        }
                    } label: {
                        Text("Emoji")
                    }
                    .sheet(isPresented: $showingEmojiPicker) {
                        EmojiPickerSheet(selectedEmoji: $emoji)
                    }

                    //Class Color
                    ColorPicker("Color", selection: $selectedColor, supportsOpacity: false)
                        .onAppear() {
                            selectedColor = classesController.stringToColor(colorString: classItem.color)!
                        }
                }
            }
            .navigationTitle("Edit Class")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Dismiss Sheet
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(red: 44/255, green: 177/255, blue: 195/255))
                    }
                }
                
                //Add Class to classes
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        editClass()
                    }) {
                        Text("Add")
                            .bold()
                            .foregroundStyle(name.isEmpty ? .gray : Color(red: 44/255, green: 177/255, blue: 195/255))
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func editClass() {
        classesController.editClass(id: classItem.id, newName: name, newEmoji: emoji, newColor: selectedColor)
        dismiss()
    }
}

#Preview {
    AddClassItemSheet()
}

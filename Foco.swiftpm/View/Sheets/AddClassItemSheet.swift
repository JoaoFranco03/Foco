//
//  AddClassItemSheet.swift
//
//
//  Created by João Franco on 10/02/2024.
//

import SwiftUI

struct AddClassItemSheet: View {
    
    //Sheet Variables
    @Environment(\.dismiss) var dismiss
    @State private var showingEmojiPicker = false
    
    //Inputs Variables
    @State private var name: String = ""
    @State private var color: Color = .blue
    @State private var selectedEmoji: String = "🍎"
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    
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
                    
                    //Class Emoji
                    LabeledContent {
                        Button(action: {
                            showingEmojiPicker.toggle()
                        }) {
                            Text(selectedEmoji)
                        }
                    } label: {
                        Text("Emoji")
                    }
                    .sheet(isPresented: $showingEmojiPicker) {
                        EmojiPickerSheet(selectedEmoji: $selectedEmoji)
                    }
                    
                    //Class Color
                    ColorPicker("Color", selection: $color, supportsOpacity: false)
                }
            }
            .navigationTitle("Add Class")
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
                        classesController.addClass(title: name, emoji: selectedEmoji, color: color)
                        dismiss()
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
}

#Preview {
    AddClassItemSheet()
}

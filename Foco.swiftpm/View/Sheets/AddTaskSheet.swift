//
//  AddTaskSheet.swift
//
//
//  Created by João Franco on 20/02/2024.
//

import SwiftUI

struct AddTaskSheet: View {
    
    //Sheet Variables
    @Environment(\.dismiss) var dismiss
    
    //Input Variabls
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var color: Color = .blue
    @State var date: Date = Date()
    @State private var selectedClass: ClassItem?
    @State private var isExamOption = false
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    //Task or Exam Picker
                    Section {
                        Picker("Picker", selection: $isExamOption) {
                            Text("Task").tag(false)
                            Text("Exam").tag(true)
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color.clear)
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Task Type")
                    }
                    
                    Section(header: Text("Task Details")) {
                        //Task Title
                        LabeledContent {
                            TextField("Title", text: $title)
                                .multilineTextAlignment(.trailing)
                        } label: {
                            Text("Title")
                        }
                        
                        //Task Description
                        LabeledContent {
                            TextField("Description", text: $description)
                                .multilineTextAlignment(.trailing)
                        } label: {
                            Text("Description")
                        }
                        
                        //Task Class
                        Picker("Class", selection: $selectedClass) {
                            Text("None").tag(nil as ClassItem?) // Use nil as the tag for "None"
                            ForEach(classesController.classes) { classItem in
                                Text(classItem.name).tag(classItem as ClassItem?)
                            }
                        }
                        
                        //Task Date
                        DatePicker("Select a Date",
                                   selection: $date,
                                   displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
            }
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                //Dismiss
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blue)
                    })
                }
                //Add Task to [tasks]
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        if (selectedClass != nil) {
                            tasksController.addTask(title: title, description: description, isExam: isExamOption, classID: selectedClass!.id, date: date)
                        } else {
                            tasksController.addTask(title: title, description: description, isExam: isExamOption, date: date)
                        }
                        dismiss()
                        
                    }, label: {
                        Text("Add")
                            .bold()
                            .foregroundStyle(title.isEmpty ? .gray : .blue)
                    }).disabled(title.isEmpty)
                }
            })
        }
    }
}

#Preview {
    AddTaskSheet()
}

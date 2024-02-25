//
//  EditTaskSheet.swift
//
//
//  Created by João Franco on 24/02/2024.
//

import SwiftUI

struct EditTaskSheet: View {
    
    //Sheet Variables
    @Environment(\.dismiss) var dismiss
    
    //Input Variabls
    var task: Task
    @State private var title: String = ""
    @State private var description: String = ""
    @State var date: Date = Date()
    @State private var selectedClass: ClassItem?
    @State private var isExamOption = false
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    
    //Set Inputs to Card Attributes
    init(task: Task) {
        self.task = task
        _title = State(initialValue: task.title)
        _description = State(initialValue: task.description)
        _date = State(initialValue: task.date)
        _description = State(initialValue: task.description)
        _isExamOption = State(initialValue: task.isExam)
    }
    
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
                        .onAppear {
                            if let classID = task.classID,
                               let classItem = classesController.getClassesByID(classID: classID) {
                                selectedClass = classItem
                            } else {
                                selectedClass = nil
                            }
                        }
                        
                        //Task Date
                        DatePicker("Select a Date",
                                   selection: $date,
                                   displayedComponents: [.date, .hourAndMinute])
                    }
                }
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blue)
                    })
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        if let classID = selectedClass?.id {
                            tasksController.editTask(id: task.id, newTitle: title, newDescription: description, newIsExam: isExamOption, newClassID: classID, newDate: date)
                        } else {
                            tasksController.editTask(id: task.id, newTitle: title, newDescription: description, newIsExam: isExamOption, newClassID: UUID(), newDate: date)
                        }
                        dismiss()
                        
                    }, label: {
                        Text("Edit")
                            .bold()
                            .foregroundStyle(title.isEmpty ? .gray : .blue)
                    }).disabled(title.isEmpty)
                }
            })
        }
    }
}

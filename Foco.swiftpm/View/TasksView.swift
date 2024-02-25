//
//  TasksView.swift
//  Foco
//
//  Created by João Franco on 19/02/2024.
//

import SwiftUI

struct TasksView: View {
    //Environment
    @Environment(\.colorScheme) var colorScheme
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    
    //Sheets
    @State private var showingAddTaskSheet = false
    
    //Task Type
    @State private var selectedTypeTask = 0
    
    //Group Tasks by Date
    private var groupedTasks: [Date: [Task]] {
        let filteredTasks: [Task]
        
        switch selectedTypeTask {
        case 0: // All
            filteredTasks = tasksController.tasks
        case 1: // Tasks
            filteredTasks = tasksController.tasks.filter { !$0.isExam }
        case 2: // Exams
            filteredTasks = tasksController.tasks.filter { $0.isExam }
        default:
            filteredTasks = tasksController.tasks
        }
        
        return Dictionary(grouping: filteredTasks, by: { task in
            Calendar.current.startOfDay(for: task.date)
        })
    }
    
    //BG Gradient
    var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 33/255, green: 71/255, blue: 115/255),
                Color(red: 8/255, green: 24/255, blue: 34/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ) :
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 246/255, green: 250/255, blue: 255/255),
                Color(red: 157/255, green: 205/255, blue: 235/255)
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
                    //Tasks Empty State
                    if (groupedTasks.isEmpty){
                        if #available(iOS 17.0, *) {
                            ContentUnavailableView {
                                if (tasksController.tasks.filter { !$0.isExam }.isEmpty) {
                                    Label("No Tasks Yet", systemImage: "checkmark.circle")
                                } else {
                                    Label("No Exams Yet", systemImage: "doc")
                                }
                            } description: {
                                if (tasksController.tasks.filter { !$0.isExam }.isEmpty) {
                                    Text("Create your first task to get started.")
                                } else {
                                    Text("Create your first exam to get started.")
                                    
                                }
                            } actions: {
                                Button("Create new task") {
                                    showingAddTaskSheet.toggle()
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.blue)
                            }
                        } else {
                            Text("Please add a new Task")
                            Button("Create new task") {
                                showingAddTaskSheet.toggle()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                        }
                    } else {
                        //Tasks
                        ScrollView{
                            VStack{
                                ForEach(groupedTasks.sorted(by: { $0.key < $1.key }), id: \.key) { date, tasksInDate in
                                    Group {
                                        HStack{
                                            Text(date, style: .date)
                                                .font(.headline)
                                                .padding(.top)
                                            Spacer()
                                        }
                                        
                                        ForEach(tasksInDate) { task in
                                            NavigationLink(destination: TaskDetailView(task: task)) {
                                                TaskItemView(task: task)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                        }
                        .scrollContentBackground(.hidden)
                    }
                    
                    //Tasks Type Picker
                    if !tasksController.tasks.isEmpty{
                        Picker("Picker", selection: $selectedTypeTask) {
                            Text("All").tag(0)
                            Text("Tasks").tag(1)
                            Text("Exams").tag(2)
                        }
                        .padding(.bottom)
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .padding(.bottom, 60)
                        .frame(maxWidth: 685)
                    }
                }
                .navigationTitle("Tasks")
            }
            .toolbar {
                //Add
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddTaskSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                    .popover(isPresented: $showingAddTaskSheet) {
                        AddTaskSheet()
                            .frame(minWidth: 400, minHeight: 380)
                    }
                }
            }
        }
    }
}

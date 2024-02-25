//
//  ClassDetailView.swift
//  Foco
//
//  Created by João Franco on 16/02/2024.
//

import SwiftUI

struct ClassDetailView: View {
    //Environment Variables
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    
    //Properties
    var classItem: ClassItem
    
    @State private var showingEditSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [(classesController.stringToColor(colorString: classItem.color)!).opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(alignment:.leading) {
                    ScrollView{
                        VStack(alignment: .leading){
                            if tasksController.getTasksForClass(classID: classItem.id).filter({ $0.isExam }).isEmpty {
                                if #available(iOS 17.0, *) {
                                    VStack{
                                        ContentUnavailableView {
                                            Label("No Exams Yet", systemImage: "doc")
                                        } description: {
                                            Text("Create a new exam to get started.")
                                        }
                                    }
                                    .background {
                                        if colorScheme == .dark {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.white.opacity(0.1))
                                        } else {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.white.opacity(0.5))
                                        }
                                    }    
                                } else {
                                    Text("Please add a new Exam")
                                }
                            } else {
                                Text("Exams:")
                                    .font(.headline)
                                    .bold()
                                ForEach(tasksController.getTasksForClass(classID: classItem.id).filter { $0.isExam }) { task in
                                    NavigationLink(destination: TaskDetailView(task: task)) {
                                        TaskItemView(task: task)
                                    }
                                }
                            }
                            
                            if tasksController.getTasksForClass(classID: classItem.id).filter({ !$0.isExam }).isEmpty {
                                if #available(iOS 17.0, *) {
                                    VStack{
                                        ContentUnavailableView {
                                            Label("No Tasks Yet", systemImage: "checkmark.circle")
                                        } description: {
                                            Text("Create a new task to get started.")
                                        }
                                    }
                                    .background {
                                        if colorScheme == .dark {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.white.opacity(0.1))
                                        } else {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.white.opacity(0.5))
                                        }
                                    }
                                } else {
                                    Text("Please add a new Task")
                                }
                            } else {
                                Text("Tasks:")
                                    .font(.headline)
                                    .bold()
                                    .padding(.top,5)
                                ForEach(tasksController.getTasksForClass(classID: classItem.id).filter { !$0.isExam }) { task in
                                    NavigationLink(destination: TaskDetailView(task: task)) {
                                        TaskItemView(task: task)
                                    }
                                }
                            }
                            
                            if flashCardsDeckController.getDecksForClass(classID: classItem.id).isEmpty {
                                if #available(iOS 17.0, *) {
                                    VStack{
                                        ContentUnavailableView {
                                            Label("No Decks Yet", systemImage: "rectangle.on.rectangle.angled")
                                        } description: {
                                            Text("Create a new deck to get started.")
                                        }
                                    }
                                    .background {
                                        if colorScheme == .dark {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.white.opacity(0.1))
                                        } else {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.white.opacity(0.5))
                                        }
                                    }
                                } else {
                                    Text("Please add a new Deck")
                                }
                            } else {
                                Text("Decks:")
                                    .font(.headline)
                                    .bold()
                                    .padding(.top,5)
                                ForEach(flashCardsDeckController.getDecksForClass(classID: classItem.id)) { deck in
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
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 80)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(classItem.name)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        showingEditSheet.toggle()
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                            .foregroundStyle((classesController.stringToColor(colorString: classItem.color)!))
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        showingAlert = true
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                            .foregroundStyle((classesController.stringToColor(colorString: classItem.color)!))
                    }
                }
            }
            .alert("Delete Class?", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) {
                    classesController.deleteClass(id:classItem.id)
                    tasksController.deleteAllTasksWithClassID(classID: classItem.id)
                    flashCardsDeckController.deleteAllDecksWithClassID(classID: classItem.id)
                    self.presentationMode.wrappedValue.dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action will permanently delete the class and all associated content.")
            }
            .sheet(isPresented: $showingEditSheet) {
                EditClassItemSheet(classItem: classItem)
            }
        }
    }
}

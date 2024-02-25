//
//  TaskDetailView.swift
//
//
//  Created by João Franco on 24/02/2024.
//

import SwiftUI

struct TaskDetailView: View {
    //Environment Variables
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    //Controllers
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    
    //Sheets
    @State private var showingEditSheet = false
    
    //Check if Task is Expired
    private var isPastDue: Bool {
        return Date() > task.date
    }
    
    //Task related to View
    var task : Task
    
    //Background Color
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
    
    //Check If Task is Expired
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, hh:mm a"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                backgroundGradient
                    .ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            
                            //Status
                            Button(action: {
                                tasksController.changeTaskStatus(id: task.id)
                            }, label: {
                                HStack {
                                    Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                        .font(.system(size: 30))
                                        .foregroundStyle(task.done ? Color.green : Color.primary.opacity(0.5))
                                    
                                }
                            })
                            
                            //Title
                            Text(task.title)
                                .font(.largeTitle).bold()
                            
                            Spacer()
                            
                            //Is Exam
                            Text(task.isExam ? "Exam" : "Task")
                                .font(.system(.headline, weight: .bold))
                                .padding(5)
                                .padding(.horizontal, 5)
                                .background(task.isExam ? Color.pink.opacity(0.4) : Color.blue.opacity(0.4))
                                .mask(Capsule())
                        }
                        HStack {
                            
                            //Time
                            HStack{
                                Image(systemName: "clock.fill")
                                    .symbolRenderingMode(.monochrome)
                                Text(self.dateFormatter.string(from: task.date)).bold()
                            }
                            .foregroundStyle(isPastDue ? Color.red : Color.primary)
                            
                            Spacer()
                            
                            //Class Info
                            HStack {
                                if let classID = task.classID {
                                    if let classInfo = classesController.getClassesByID(classID: classID) {
                                        Text("\(classInfo.emoji)\(classInfo.name)")
                                    }
                                }
                            }
                        }
                        .padding(.vertical,10)
                        
                        //Description
                        if !task.description.isEmpty {
                            Text(task.description)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background {
                                    if colorScheme == .dark {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.white.opacity(0.1))
                                    } else {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.white.opacity(0.5))
                                    }
                                }
                                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //Edit
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingEditSheet.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .foregroundStyle(Color.blue)
                    }
                }
                
                //Delete
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        tasksController.deleteTask(id: task.id)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Color.blue)
                    }
                    .foregroundStyle(Color.red)
                }
            }
        }
        //Edit Sheet
        .sheet(isPresented: $showingEditSheet) {
            EditTaskSheet(task: task)
        }
    }
}


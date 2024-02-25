//
//  TaskItemView.swift
//
//
//  Created by João Franco on 21/02/2024.
//

import SwiftUI

struct TaskItemView: View {
    @Environment(\.colorScheme) var colorScheme
    var task: Task
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    
    //Sheets
    @State private var showingEditSheet = false
    
    //Formar data to be like Feb 25, 06:02 PM
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, hh:mm a"
        return formatter
    }
    
    //Check If Task is Expired
    private var isPastDue: Bool {
        return Date() > task.date
    }
    
    var body: some View {
        ZStack {
            VStack{
                //Task / Exam
                Text(task.isExam ? "Exam" : "Task")
                    .font(.system(.headline, weight: .bold))
                    .padding(5)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity)
                    .background(task.isExam ? Color.pink.opacity(0.4) : Color.blue.opacity(0.4))
                    .mask(Capsule())
                
                HStack {
                    //Change Status (After 5 seconds delete)
                    Button(action: {
                        tasksController.changeTaskStatus(id: task.id)
                    }, label: {
                        HStack {
                            Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 30))
                                .foregroundStyle(task.done ? Color.green : Color.primary.opacity(0.5))
                            
                        }
                    })
                    VStack(alignment: .leading) {
                        //Title
                        HStack{
                            Text(task.title)
                                .multilineTextAlignment(.leading)
                                .font(.system(.title3, weight: .bold))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        //Description
                        Text(task.description)
                            .font(.system(.callout, weight: .regular))
                            .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth:.infinity)
                }
                .padding(.bottom,5)
                Rectangle()
                    .frame(height: 1, alignment: .top)
                    .foregroundColor(Color.gray)
                HStack {
                    //Time
                    HStack {
                        Image(systemName: "clock.fill")
                            .symbolRenderingMode(.monochrome)
                        Text(self.dateFormatter.string(from: task.date))
                            .multilineTextAlignment(.leading)
                            .bold()
                    }
                    .foregroundStyle(isPastDue ? Color.red : Color.primary)
                    Spacer()
                    //Class
                    HStack {
                        if let classID = task.classID {
                            if let classInfo = classesController.getClassesByID(classID: classID) {
                                Text(classInfo.emoji)
                                Text(classInfo.name)
                                    .multilineTextAlignment(.leading)
                                    .bold()
                            }
                        }
                    }
                }
                .padding(.top, 15)
                
            }
            .foregroundStyle(Color.primary)
            .padding()
            .background {
                if colorScheme == .dark {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.opacity(0.1))
                } else {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.opacity(0.5))
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
            )
            
            //Quick Actions
            .contextMenu {
                Button(role: .destructive, action: {
                    tasksController.deleteTask(id: task.id)
                }) {
                    Label("Delete", systemImage: "trash")
                }
                Button(action: {
                    showingEditSheet.toggle()
                }) {
                    Label("Edit", systemImage: "pencil")
                }
            }
        }
        //Edit Sheet
        .sheet(isPresented: $showingEditSheet) {
            EditTaskSheet(task: task)
        }
    }
}

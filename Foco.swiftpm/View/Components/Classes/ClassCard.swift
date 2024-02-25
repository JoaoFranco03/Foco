//
//  ClassCard.swift
//
//
//  Created by João Franco on 19/02/2024.
//

import Foundation
import SwiftUI

struct ClassCard: View{
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    @EnvironmentObject var tasksController: TasksController
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    
    //Sheets
    @State private var showingEditSheet = false
    
    //Parametes
    let classItem: ClassItem
    
    @State private var showingAlert = false
    
    var body: some View {
        let color =  classesController.stringToColor(colorString: classItem.color)!
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
                .background(Material.regular)
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.5))
                .background(Material.ultraThin)
            
            HStack {
                Text(classItem.emoji)
                Text(classItem.name)
                    .font(.system(.largeTitle, weight: .bold))
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .symbolRenderingMode(.monochrome)
            }
            .padding()
        }
        .foregroundStyle(Color.primary)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
        )
        
        //Long Press Options
        .contextMenu {
            Button(role: .destructive, action: {
                showingAlert = true
            }) {
                Label("Delete", systemImage: "trash")
            }
            Button(action: {
                showingEditSheet.toggle()
            }) {
                Label("Edit", systemImage: "pencil")
            }
        }
        
        //Alert for warning user that this will delete all associated content
        .alert("Delete Class?", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {
                classesController.deleteClass(id:classItem.id)
                tasksController.deleteAllTasksWithClassID(classID: classItem.id)
                flashCardsDeckController.deleteAllDecksWithClassID(classID: classItem.id)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action will permanently delete the class and all associated content.")
        }
        
        //Edit Sheet
        .sheet(isPresented: $showingEditSheet) {
            EditClassItemSheet(classItem: classItem)
        }
    }
}

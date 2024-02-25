//
//  ResourcesView.swift
//  Foco
//
//  Created by João Franco on 16/02/2024.
//

import SwiftUI

struct ClassesView: View {
    
    //Light / Dark Mode Detector
    @Environment(\.colorScheme) var colorScheme
    
    //Controllers
    @EnvironmentObject var classesController: ClassesController
    
    //Sheets
    @State private var showingAddClassItemSheet = false
    
    //Background Color
    var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 55/255, green: 125/255, blue: 122/255),
                Color(red: 11/255, green: 37/255, blue: 38/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ) :
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 241/255, green: 254/255, blue: 255/255),
                Color(red: 142/255, green: 196/255, blue: 195/255)
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
                    if classesController.classes.isEmpty{
                        if #available(iOS 17.0, *) {
                            ContentUnavailableView {
                                Label("No Classes Yet", systemImage: "book")
                            } description: {
                                Text("Create your first class to get started.")
                            } actions: {
                                // 2
                                Button("Create new class") {
                                    showingAddClassItemSheet.toggle()
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Color(red: 44/255, green: 177/255, blue: 195/255))
                            }
                        } else {
                            Text("Please add a new Class")
                            Button("Create new class") {
                                showingAddClassItemSheet.toggle()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color(red: 44/255, green: 177/255, blue: 195/255))
                        }
                    } else {
                        ScrollView{
                            ForEach(classesController.classes) { classItem in
                                NavigationLink(destination: ClassDetailView(classItem: classItem)) {
                                    ClassCard(classItem: classItem)
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .padding(.bottom, 80)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Classes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddClassItemSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(red: 44/255, green: 177/255, blue: 195/255))
                    }
                    .popover(isPresented: $showingAddClassItemSheet) {
                        AddClassItemSheet()
                            .frame(minWidth: 400, minHeight: 240)
                    }
                }
            }
        }
    }
}

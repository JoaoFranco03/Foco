//
//  ForTodayView.swift
//  Foco
//
//  Created by João Franco on 11/02/2024.
//

import SwiftUI

struct OverviewView: View {
    //Environment Variables
    @Environment(\.colorScheme) var colorScheme
    
    //Controllers
    @EnvironmentObject var tasksController: TasksController
    
    //Quotes
    let quoteDatabase = QuoteDatabase()
    @State private var selectedQuoteID: UUID?
    
    //Number of exams to show
    private let numberOfExams = 7
    
    //BG Gradient
    var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 125/255, green: 55/255, blue: 118/255),
                Color(red: 37/255, green: 11/255, blue: 38/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ) :
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 255/255, green: 244/255, blue: 255/255),
                Color(red: 212/255, green: 158/255, blue: 207/255),
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
                    ScrollView{
                        //Quotes
                        QuoteView(quote: quoteDatabase.getRandomQuote())
                        
                        //Next Exams
                        if tasksController.getNextExams(count: numberOfExams).isEmpty{
                            if #available(iOS 17.0, *) {
                                ContentUnavailableView {
                                    Label("You don't have any exams", systemImage: "doc")
                                } description: {
                                    Text("Enjoy your deserved free time 😉")
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Material.ultraThin)
                                }
                            } else {
                                Text("Please add a new Class")
                            }
                            
                        } else {
                            VStack(alignment:.leading) {
                                HStack{
                                    Text("Next Exams:")
                                        .font(.headline)
                                        .bold()
                                    Spacer()
                                }
                                ForEach(tasksController.getNextExams(count: numberOfExams)) { task in
                                    NavigationLink(destination: TaskDetailView(task: task)) {
                                        TaskItemView(task: task)
                                    }
                                }
                            }
                            .padding()
                            .background(Material.ultraThin)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                            )
                            .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        
                        //Study Minutes Goal
                        GoalCard()
                            .padding(.bottom, 80)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Overview")
            }
            .toolbar {
                //View All Quotes Button
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink {
                        QuotesView()
                    } label: {
                        Image(systemName: "quote.opening")
                            .foregroundStyle(Color(red: 237/255, green: 106/255, blue: 208/255))
                    }
                }
            }
        }
    }
}

#Preview {
    OverviewView()
}

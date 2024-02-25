//
//  AddFlashCardToDeck.swift
//
//
//  Created by João Franco on 18/02/2024.
//

import Foundation
import SwiftUI
import Combine


struct AddFlashCardToDeckSheet: View {
    
    //Sheet Variables
    @Environment(\.dismiss) var dismiss
    
    //Inputs Variables
    var deck: FlashCardsDeck
    @State private var question: String = ""
    @State private var answer: String = ""
    
    //Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    //Flash Card Question
                    Section(header: Text("Question")){
                        TextField("Question Text",text: $question,axis: .vertical)
                    }
                    
                    //Flash Card Answer
                    Section(header: Text("Answer")){
                        TextField("Answer Text",text: $answer,axis: .vertical)
                    }
                }
            }
            .navigationTitle("Add New Flash Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                
                //Dismiss Sheet
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.blue)
                    })
                }
                
                //Add Flash Card to deck
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        if flashCardsDeckController.decks.firstIndex(where: { $0.id == deck.id }) != nil {
                            flashCardsDeckController.addFlashCardToDeck(deckID: deck.id, question: question, answer: answer)
                        }
                        dismiss()
                    }, label: {
                        Text("Add")
                            .bold()
                            .foregroundStyle((question.isEmpty || answer.isEmpty) ? .gray : .blue)
                    }).disabled(question.isEmpty || answer.isEmpty)
                }
            })
        }
    }
}

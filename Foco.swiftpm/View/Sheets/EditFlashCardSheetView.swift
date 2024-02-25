//
//  EditFlashCard.swift
//
//
//  Created by João Franco on 18/02/2024.
//

import Foundation
import SwiftUI

struct EditFlashCardSheetView: View {
    //Environment Variables
    @Environment(\.dismiss) var dismiss
    
    //Inputs Variables
    var deck: FlashCardsDeck
    var card: FlashCard
    
    //Controller
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    
    //Inputs
    @State private var question: String = ""
    @State private var answer: String = ""
    
    //Set Inputs to Card Attributes
    init(deck: FlashCardsDeck, card: FlashCard) {
        self.deck = deck
        self.card = card
        _question = State(initialValue: card.question)
        _answer = State(initialValue: card.answer)
    }

    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    //Question
                    Section(header: Text("Question")){
                        TextField("Question Text",text: $question,axis: .vertical)
                    }
                    
                    //Answer
                    Section(header: Text("Answer")){
                        TextField("Answer Text",text: $answer,axis: .vertical)
                    }
                }
            }
            .navigationTitle("Edit New Flash Card")
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
                
                //Edit
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        flashCardsDeckController.editFlashCard(deckID: deck.id, flashCard: card, newQuestion: question, newAnswer: answer)
                        dismiss()
                    }, label: {
                        Text("Edit")
                            .bold()
                            .foregroundStyle((question.isEmpty || answer.isEmpty) ? .gray : .blue)
                    }).disabled(question.isEmpty || answer.isEmpty)
                }
            })
        }
    }
}

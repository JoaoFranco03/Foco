//
//  FlashCardView.swift
//
//
//  Created by João Franco on 12/02/2024.
//

import SwiftUI

import SwiftUI

struct FlashCardView: View {
    //Sheets
    @State private var showingEditFlashCard = false
    
    //Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    
    //Parameterers
    var deck:FlashCardsDeck
    var card:FlashCard
    
    //Change side of Card
    @State var flipped = false
    
    var body: some View {
        VStack{
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                    )
                    .foregroundStyle(self.flipped ? Color.green.opacity(0.4) : Color.blue.opacity(0.4))
                    .frame(minHeight: 150)
                Text(flipped ? card.answer : card.question)
                    .multilineTextAlignment(.center)
                    .padding()
                    .rotation3DEffect(self.flipped ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
            }
        }
        .onTapGesture {
            withAnimation {
                self.flipped.toggle()
            }
        }
        .rotation3DEffect(self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
        
        //Long Press Options
        .contextMenu {
            Button {
                showingEditFlashCard.toggle()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button(role: .destructive, action: {
                flashCardsDeckController.deleteFlashCardFromDeck(deckID: deck.id, flashCard: card)
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
        //Edit Sheet
        .sheet(isPresented: $showingEditFlashCard) {
            EditFlashCardSheetView(deck: deck, card: card)
        }
    }
}

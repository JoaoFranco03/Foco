//
//  DeckView.swift
//
//
//  Created by João Franco on 24/02/2024.
//

import SwiftUI

struct DeckView: View {
    // Controllers
    @EnvironmentObject var flashCardsDeckController: FlashCardsDeckController
    @EnvironmentObject var classesController: ClassesController
    
    // Deck associated with this view
    let deck: FlashCardsDeck
    
    // State variables
    @State private var color: Color = .white
    @State private var classItem: ClassItem?
    
    // Sheet presentation state
    @State private var showingEditSheet = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .background(Material.regular)
            RoundedRectangle(cornerRadius: 10)
                .fill(color.opacity(0.5))
            
            HStack {
                Text(deck.name)
                    .font(.system(.largeTitle, weight: .bold))
                    .foregroundStyle(Color.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
                    Text("\(deck.flashCards.count) Flash Cards")
                        .bold()
                        .foregroundStyle(Color.primary.opacity(0.75))
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.primary.opacity(0.75))
                    .imageScale(.large)
                    .symbolRenderingMode(.monochrome)
            }
            .padding()
        }
        .onAppear {
            // Fetch the associated class and update the color
            updateColor()
        }
        .onChange(of: deck.classID) { _ in
            // When the class ID changes, update the color
            updateColor()
        }
        .frame(maxWidth: .infinity)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
        )
        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        
        // Long Press Options
        .contextMenu {
            Button(role: .destructive, action: {
                flashCardsDeckController.deleteDeck(id: deck.id)
            }) {
                Label("Delete", systemImage: "trash")
            }
            Button(action: {
                showingEditSheet.toggle()
            }) {
                Label("Edit", systemImage: "pencil")
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditDeckSheet(deck: deck)
        }
    }
    
    private func updateColor() {
        if let classID = deck.classID,
           let updatedClassItem = classesController.getClassesByID(classID: classID) {
            color = classesController.stringToColor(colorString: updatedClassItem.color) ?? .white
            classItem = updatedClassItem
        } else {
            color = .white
            classItem = nil
        }
    }
}

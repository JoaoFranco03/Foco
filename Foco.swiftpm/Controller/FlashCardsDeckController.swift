//
//  FlashCardsDeckController.swift
//
//
//  Created by João Franco on 18/02/2024.
//

import Foundation

class FlashCardsDeckController: ObservableObject {
    var classesController: ClassesController = ClassesController()
    @Published var decks: [FlashCardsDeck] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "decks"
    
    init() {
        getDecks()
    }
    
    //CRUD Functions
    func getDecks() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedDecks = try? JSONDecoder().decode([FlashCardsDeck].self, from: data)
        else { return }
        
        self.decks = savedDecks
    }
    
    func deleteDeck(id: UUID) {
        if let index = decks.firstIndex(where: { $0.id == id }) {
            decks.remove(at: index)
            objectWillChange.send()
            saveItems()
        }
    }
    
    func addDeck(name: String, classID: UUID) {
        let newDeck = FlashCardsDeck(name: name, classID: classID)
        decks.append(newDeck)
    }
    func addDeck(name: String) {
        let newDeck = FlashCardsDeck(name: name)
        decks.append(newDeck)
    }
    
    func addFlashCardToDeck(deckID: UUID, question: String, answer: String) {
        if let deckIndex = decks.firstIndex(where: { $0.id == deckID }) {
            // Create a new flash card
            let newFlashCard = FlashCard(question: question, answer: answer, dateOfCreation: Date())
            decks[deckIndex].flashCards.append(newFlashCard)
            
            //Notify @Published (Update Cards in Deck View)
            objectWillChange.send()
            
            saveItems()
        }
    }
    
    func deleteFlashCardFromDeck(deckID: UUID, flashCard: FlashCard) {
        if let deckIndex = decks.firstIndex(where: { $0.id == deckID }) {
            if let flashCardIndex = decks[deckIndex].flashCards.firstIndex(where: { $0.id == flashCard.id }) {
                decks[deckIndex].flashCards.remove(at: flashCardIndex)
                
                // Notify @Published (Update Cards in Deck View)
                objectWillChange.send()
                
                saveItems()
            }
        }
    }
    
    func editDeck(deckID: UUID, newName: String, classID: UUID) {
        if let deckIndex = decks.firstIndex(where: { $0.id == deckID }) {
                decks[deckIndex].name = newName
                decks[deckIndex].classID = classID

                objectWillChange.send()
                
            classesController.update()
                classesController.saveItems()
                saveItems()
        }
    }
    
    func getDecksForClass(classID: UUID) -> [FlashCardsDeck] {
        return decks.filter { $0.classID == classID }
    }
    
    func deleteAllDecksWithClassID(classID: UUID) {
        let deletedDecks = decks.filter { $0.classID == classID }
        
        decks = decks.filter { $0.classID != classID }
        
        for deck in deletedDecks {
            deck.flashCards = []
        }
        
        saveItems()
    }
    
    func editFlashCard(deckID: UUID, flashCard: FlashCard, newQuestion: String, newAnswer: String) {
        if let deckIndex = decks.firstIndex(where: { $0.id == deckID }) {
            if let flashCardIndex = decks[deckIndex].flashCards.firstIndex(where: { $0.id == flashCard.id }) {
                decks[deckIndex].flashCards[flashCardIndex].question = newQuestion
                decks[deckIndex].flashCards[flashCardIndex].answer = newAnswer
                
                objectWillChange.send()
                
                saveItems()
            }
        }
    }

    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(decks) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

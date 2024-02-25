//
//  FlashCardsDeck.swift
//
//
//  Created by João Franco on 17/02/2024.
//

import SwiftUI

class FlashCardsDeck: Codable, Identifiable {
    var id: UUID
    var name: String
    var classID: UUID?
    var flashCards: [FlashCard]
    
    init(id: UUID = UUID(), name: String, classID: UUID? = nil, flashCards: [FlashCard] = []) {
        self.id = id
        self.name = name
        self.classID = classID
        self.flashCards = flashCards
    }
}

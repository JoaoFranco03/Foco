//
//  FlashCard.swift
//
//
//  Created by João Franco on 17/02/2024.
//

import SwiftUI

class FlashCard: Codable, Identifiable {
    var identifier: UUID
    var question: String
    var answer: String
    var dateOfCreation: Date
    
    init(identifier: UUID = UUID(), question: String, answer: String, dateOfCreation: Date) {
        self.identifier = identifier
        self.question = question
        self.answer = answer
        self.dateOfCreation = dateOfCreation
    }
}


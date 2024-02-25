//
//  ClassItem.swift
//
//
//  Created by João Franco on 16/02/2024.
//

import SwiftUI

class ClassItem: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var emoji: String
    var color: String

    init(id: UUID = UUID(), name: String, emoji: String, color: String) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.color = color
    }

    //To work with Picker
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(emoji)
        hasher.combine(color)
    }

    static func == (lhs: ClassItem, rhs: ClassItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.emoji == rhs.emoji &&
               lhs.color == rhs.color
    }
}


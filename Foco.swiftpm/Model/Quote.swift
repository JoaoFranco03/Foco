//
//  Quote.swift
//
//
//  Created by João Franco on 11/02/2024.
//

import Foundation

struct Quote: Hashable{
    var id = UUID()
    var text: String
    var author: String
}

struct QuoteDatabase {
    let quotes: [Quote] = [
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
        Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston S. Churchill"),
        Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon"),
        Quote(text: "The greatest glory in living lies not in never falling, but in rising every time we fall.", author: "Nelson Mandela"),
        Quote(text: "The only thing we have to fear is fear itself.", author: "Franklin D. Roosevelt"),
        Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
        Quote(text: "The time is always right to do what is right.", author: "Martin Luther King Jr."),
        Quote(text: "Our doubts are traitors, and make us lose the good we oft might win, by fearing to attempt.", author: "William Shakespeare, Measure for Measure (Act 1, Scene 4)")
    ]
    
    func getRandomQuote() -> Quote {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: Date())
        
        // Random Seed
        let randomIndex = day % quotes.count
        return quotes[randomIndex]
    }
    
    func getQuote(byId id: UUID) -> Quote? {
        return quotes.first { $0.id == id }
    }
}

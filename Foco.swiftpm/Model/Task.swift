//
//  Task.swift
//
//
//  Created by João Franco on 19/02/2024.
//

import Foundation

class Task: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
    var isExam: Bool
    var classID: UUID?
    var date: Date
    var done: Bool

    //Initializer with Class
    init(id: UUID = UUID(), title: String, description: String, isExam: Bool, classID: UUID, date: Date, done: Bool ) {
        self.id = id
        self.title = title
        self.description = description
        self.isExam = isExam
        self.classID = classID
        self.date = date
        self.done = done
    }
    
    //Initializer without Class
    init(id: UUID = UUID(), title: String, description: String, isExam: Bool, date: Date, done: Bool ) {
        self.id = id
        self.title = title
        self.description = description
        self.isExam = isExam
        self.date = date
        self.done = done
    }

}

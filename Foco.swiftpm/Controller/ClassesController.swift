//
//  ClassesController.swift
//
//
//  Created by João Franco on 18/02/2024.
//

import UIKit
import SwiftUI

class ClassesController: ObservableObject {
    @Published var classes: [ClassItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "classes"
    
    init() {
        getClasses()
    }
    
    //CRUD Functions
    func getClasses() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedClasses = try? JSONDecoder().decode([ClassItem].self, from: data)
        else { return }
        
        self.classes = savedClasses
    }
    
    func deleteClass(id: UUID) {
        if let index = classes.firstIndex(where: { $0.id == id }) {
            classes.remove(at: index)
        }
    }
    
    func addClass(title: String, emoji:String, color: Color) {
        let stringColor = colorPickerToColor(color: color)
        let newClass = ClassItem(name: title, emoji: emoji, color: stringColor)
        classes.append(newClass)
    }
    
    func editClass(id: UUID, newName: String, newEmoji: String, newColor: Color) {
        let stringColor = colorPickerToColor(color: newColor)
        if let index = classes.firstIndex(where: { $0.id == id }) {
            classes[index].name = newName
            classes[index].emoji = newEmoji
            classes[index].color = stringColor
            
            objectWillChange.send()
            
            saveItems()
        }
    }
    
    func getClassesByID(classID: UUID) -> ClassItem? {
        return classes.first(where: { $0.id == classID })
    }
    
    func update() {
        objectWillChange.send()
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(classes) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    //Color Function
    func colorPickerToColor(color: Color)-> String {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return "\(red),\(green),\(blue),\(alpha)"
    }
    
    func stringToColor(colorString: String) -> Color? {
        guard colorString != "" else {
            return Color.white
        }

        let rgbArray = colorString.components(separatedBy: ",")
        guard rgbArray.count == 4,
              let red = Double(rgbArray[0]),
              let green = Double(rgbArray[1]),
              let blue = Double(rgbArray[2]),
              let alpha = Double(rgbArray[3]) else {
            return Color.white
        }

        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

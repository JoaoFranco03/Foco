//
//  TasksController.swift
//
//
//  Created by João Franco on 20/02/2024.
//

import Foundation

class TasksController: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "tasks"
    
    // Schedule deletion of completed tasks after 5s delay
    var deletionWorkItem: DispatchWorkItem?
    
    init() {
        getTasks()
    }
    
    //CRUD Functions
    func getTasks() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedTasks = try? JSONDecoder().decode([Task].self, from: data)
        else { return }
        
        self.tasks = savedTasks
    }
    
    func deleteTask(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks.remove(at: index)
        }
    }
    
    func addTask(title: String, description:String, isExam:Bool, classID: UUID, date: Date) {
        let newTask = Task(title: title, description: description, isExam:isExam, classID: classID, date: date, done: false)
        tasks.append(newTask)
    }
    
    func addTask(title: String, description:String, isExam:Bool, date: Date) {
        let newTask = Task(title: title, description: description, isExam:isExam, date: date, done: false)
        tasks.append(newTask)
    }
    
    func editTask(id: UUID, newTitle: String, newDescription:String, newIsExam:Bool, newClassID: UUID, newDate: Date) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].title = newTitle
            tasks[index].description = newDescription
            tasks[index].isExam = newIsExam
            tasks[index].classID = newClassID
            tasks[index].date = newDate
            objectWillChange.send()
            saveItems()
        }
    }
    
    func changeTaskStatus(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].done.toggle()
            objectWillChange.send()
            saveItems()

            // Cancel any previously scheduled deletion
            deletionWorkItem?.cancel()

            if tasks[index].done {
                // Schedule deletion after 5 seconds
                deletionWorkItem = DispatchWorkItem { [weak self] in
                    self?.deleteTask(id: id)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: deletionWorkItem!)
            }
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }

    func getTasksForClass(classID: UUID) -> [Task] {
        return tasks.filter { $0.classID == classID }
    }
    
    func getNextExams(count: Int) -> [Task] {
        // Filter tasks for exams and sort them by date
        let examTasks = tasks.filter { $0.isExam }
                             .sorted { $0.date < $1.date }
        
        // Return the specified number of exams or all exams if there are fewer
        return Array(examTasks.prefix(count))
    }
    
    func deleteAllTasksWithClassID(classID: UUID) {
        tasks = tasks.filter { $0.classID != classID }
        saveItems()
    }
}

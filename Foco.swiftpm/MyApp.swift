import SwiftUI
import TipKit

@main
struct MyApp: App {
    @StateObject private var timeManager = TimerController()
    @StateObject var classesController = ClassesController()
    @StateObject var flashCardsDeckController = FlashCardsDeckController()
    @StateObject var tasksController = TasksController()
    @StateObject var onboardingController = OnboardingController()
    
    @AppStorage("initialDataPopulated") var initialDataPopulated = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timeManager)
                .environmentObject(classesController)
                .environmentObject(flashCardsDeckController)
                .environmentObject(tasksController)
                .sheet(isPresented: $onboardingController.showOnboarding) {
                    OnboardingSheet()
                        .environmentObject(onboardingController)
                    
                }
                .onAppear {
                    if !initialDataPopulated {
                        populateInitialData()
                        initialDataPopulated = true
                    }
                    
                }
                .task {
                    if #available(iOS 17.0, *) {
                        try? Tips.configure()
                    }
                }
        }
    }
    
    func populateInitialData() {
        
        func dateFiveHoursFromNow() -> Date {
            let calendar = Calendar.current
            let currentDate = Date()
            let fiveHoursFromNow = calendar.date(byAdding: .hour, value: 5, to: currentDate)!
            return fiveHoursFromNow
        }
        
        classesController.addClass(title: "iOS Development", emoji: "📱", color: .blue)
        classesController.addClass(title: "Data Structures", emoji: "📊", color: .green)
        
        let iosDevelopmentClassID = classesController.classes[0].id
        let dataStructuresClassID = classesController.classes[1].id
        
        flashCardsDeckController.addDeck(name: "SwiftUI", classID: iosDevelopmentClassID)
        flashCardsDeckController.addDeck(name: "UIKit", classID: iosDevelopmentClassID)
        flashCardsDeckController.addDeck(name: "Algorithms", classID: dataStructuresClassID)
        flashCardsDeckController.addDeck(name: "Networking", classID: iosDevelopmentClassID)
        
        let swiftUIDeckID = flashCardsDeckController.decks[0].id
        let uikitDeckID = flashCardsDeckController.decks[1].id
        
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is SwiftUI?", answer: "SwiftUI is a modern UI framework for building declarative user interfaces for any Apple device.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What are the key features of SwiftUI?", answer: "Key features of SwiftUI include declarative syntax, automatic UI updates, native performance, and seamless integration with Apple's platforms.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is @State?", answer: "@State is a property wrapper that allows you to manage state in SwiftUI views.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a View in SwiftUI?", answer: "A View is a fundamental building block in SwiftUI that represents a portion of your app's UI.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a modifier in SwiftUI?", answer: "A modifier is a method that you can call on a SwiftUI view to modify its appearance or behavior.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is @Binding in SwiftUI?", answer: "@Binding is a property wrapper that allows you to create a two-way binding between a view and its underlying data.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a VStack in SwiftUI?", answer: "A VStack is a container view in SwiftUI that arranges its children in a vertical stack.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a ViewModifier in SwiftUI?", answer: "A ViewModifier is a reusable configuration for a view, allowing you to apply common styling or behavior.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a VStack?", answer: "VStack is a container view that arranges its children in a vertical line.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a HStack?", answer: "HStack is a container view that arranges its children in a horizontal line.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a ZStack?", answer: "ZStack is a container view that overlays its children, stacking them in the Z-axis.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is the @EnvironmentObject property wrapper?", answer: "@EnvironmentObject is a property wrapper used to inject an object declared as an environment object into a SwiftUI view hierarchy.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is the @StateObject property wrapper?", answer: "@StateObject is a property wrapper used to automatically manage the lifecycle of an observable object in a SwiftUI view hierarchy.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is the @FetchRequest property wrapper?", answer: "@FetchRequest is a property wrapper used to fetch objects from a Core Data managed object context and automatically update the view when the fetch results change.")
        flashCardsDeckController.addFlashCardToDeck(deckID: swiftUIDeckID, question: "What is a NavigationLink?", answer: "NavigationLink is a view that triggers navigation to a destination view when tapped.")
        
        
        flashCardsDeckController.addFlashCardToDeck(deckID: uikitDeckID, question: "What is UIView?", answer: "UIView is a fundamental building block for user interfaces in UIKit.")
        flashCardsDeckController.addFlashCardToDeck(deckID: uikitDeckID, question: "What is UIViewController?", answer: "UIViewController is a class that manages a view hierarchy for your UIKit-based app.")
        
        tasksController.addTask(title: "Study Swift Functions", description: "Review and practice Swift function concepts.", isExam: false, classID: iosDevelopmentClassID, date: Date())
        tasksController.addTask(title: "Implement Data Structures", description: "Implement various data structures in Swift.", isExam: false, classID: dataStructuresClassID, date: dateFiveHoursFromNow())
        tasksController.addTask(title: "Final Exam", description: "Final exam covering iOS Development topics.", isExam: true, classID: iosDevelopmentClassID, date: dateFiveHoursFromNow())
        tasksController.addTask(title: "Midterm Exam", description: "Midterm exam covering data structures concepts.", isExam: true, classID: dataStructuresClassID, date: dateFiveHoursFromNow())
        
        classesController.saveItems()
        flashCardsDeckController.saveItems()
        tasksController.saveItems()
    }
    
}

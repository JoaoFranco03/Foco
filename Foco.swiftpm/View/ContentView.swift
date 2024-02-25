import SwiftUI

//Tabs
enum TabbedItems: Int, CaseIterable{
    case overview = 0
    case classes
    case tasks
    case decks
    case timer
    
    var title: String{
        switch self {
        case .overview:
            return "Overview"
        case .classes:
            return "Classes"
        case .tasks:
            return "Tasks"
        case .decks:
            return "Decks"
        case .timer:
            return "Timer"
        }
    }
    
    var iconName: String{
        switch self {
        case .overview:
            return "square.grid.2x2.fill"
        case .classes:
            return "book.fill"
        case .tasks:
            return "checkmark.circle.fill"
        case .decks:
            return "rectangle.fill.on.rectangle.angled.fill"
        case .timer:
            return "clock.fill"
        }
    }
    
    var iconColor: Color{
        switch self {
        case .overview:
            return Color(red: 237/255, green: 106/255, blue: 208/255)
        case .classes:
            return Color(red: 85/255, green: 196/255, blue: 196/255)
        case .tasks:
            return Color.blue
        case .decks:
            return Color(red: 169/255, green: 131/255, blue: 255/255)
        case .timer:
            return Color(red: 143/255, green: 138/255, blue: 129/255)
        }
    }
}

//For Blur under TabBar
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct ContentView: View {
    //Environment Variables
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    //Needs Onboarding
    @AppStorage("needsAppOnboarding") var needsAppOnboarding: Bool = true
    
    //Selected Tabs
    @State var selectedTab = 0
    
    //Controllers
    @EnvironmentObject var timeManager: TimerController
    
    init() {
        //Transarent unde TabBar when Scroll
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    @State var isTapped = false
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                OverviewView()
                    .tag(0)
                
                ClassesView()
                    .tag(1)
                
                TasksView()
                    .tag(2)
                
                DecksView()
                    .tag(3)
                
                TimerView()
                    .tag(4)
            }
            .padding(.bottom, -70)
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, color: item.iconColor, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .padding(5)
            .background(
                Capsule()
                    .fill(Material.ultraThin)
            )
            .background(
                Capsule()
                    .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
            )
            .zIndex(2)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 8)
            VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
                .zIndex(1)
                .mask(LinearGradient(stops: [.init(color: .white, location: 0),
                                             .init(color: .white, location: 0.4),
                                             .init(color: .clear, location: 0.65),
                                             .init(color: .clear, location: 0.8)],
                                     startPoint: .bottom, endPoint: .top))
                .ignoresSafeArea()
                .frame(height: 110)
                .allowsHitTesting(false)
        }
        .toolbar{
            ToolbarItem(placement: .principal){
                if horizontalSizeClass == .compact {
                    if selectedTab != 3
                    {
                        if timeManager.hasStarted {
                            Button {
                                withAnimation{
                                    selectedTab = 3
                                }
                            } label: {
                                HStack {
                                    if #available(iOS 17.0, *) {
                                        Image(systemName: "timer")
                                            .symbolEffect(.pulse)
                                    } else {
                                        Image(systemName: "timer")
                                    }
                                    Text(timeManager.timeFormatted())
                                }
                                .padding(5)
                                .background(Material.regular)
                                .mask(Capsule())
                            }
                        }
                    }
                }
            }
        }
    }
}

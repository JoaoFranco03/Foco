//
//  BreathAnimation.swift
//
//
//  Created by João Franco on 29/01/2024.
//

import SwiftUI

enum AnimationPhase {
    case start, breatheIn, holdIn, breatheOut, holdOut
}
class HapticManager {
    static func generateHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
}

class HoldBreathHapticManager {
    static func generateHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.warning)
    }
}

struct BreathAnimation: View {
    //Animation Variables
    var animationStyle: BreathingAnimationStyle
    @Binding var timeToRun:Bool
    @Binding var animate:Bool
    @Binding var animationPhase: AnimationPhase
    @State private var scale: Double = 2
    @State private var blur: Double = 0
    @State private var rotation: Double = 0
    @State private var breathText = "Relax, and Lay Down"
    
    //Breathing Variables
    var breatheInDuration: Double
    var breatheOutDuration: Double
    var holdInDuration: Double
    var holdOutDuration: Double
    var numberOfBreaths: Int
    @Binding var breathsTaken: Int
    
    //Timer Controller to Pause / Play
    @EnvironmentObject var timeManager: TimerController
    
    var body: some View {
        switch animationStyle {
            
        case .flower:
            ZStack {
                ForEach(0..<12) { i in
                    let angle = 2 * .pi / 12 * Double(i)
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.teal, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .scaleEffect(scale)
                        .opacity(animate ? 0.2 : 0.8)
                        .blur(radius: blur)
                        .frame(width: 80, height: 80)
                        .offset(x: animate ? CGFloat(cos(angle)) * 70 : CGFloat(cos(angle)),
                                y: animate ? CGFloat(sin(angle)) * 70 : CGFloat(cos(angle)))
                }
            }
            .rotationEffect(.degrees(rotation))
            
            //Run Animation on "Start Breathing Session" Click
            .onChange(of: timeToRun, perform: { newValue in
                if newValue {
                    runAnimation()
                }
            })
            .onAppear{
                timeManager.pauseTimer()
            }
            .onDisappear {
                //Return to Initial State
                breathsTaken = numberOfBreaths
                if timeManager.isRunning {
                    timeManager.startTimer()
                }
            }
            
        case .orb:
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .bottom, endPoint: .top))
                    .frame(width: 100, height: 100)
                    .blur(radius: 15)
                    .opacity(0.5)
                    .rotationEffect(.degrees(rotation))
            }
            .scaleEffect(scale)
            
            //Run Animation on "Start Breathing Session" Click
            .onChange(of: timeToRun, perform: { newValue in
                if newValue {
                    runAnimation()
                }
            })
            .onDisappear {
                //Return to Initial State
                breathsTaken = numberOfBreaths
                if timeManager.isRunning {
                    timeManager.startTimer()
                }
            }
            
        case .rings:
            ZStack {
                ForEach(1...5, id: \.self) { index in
                    Circle()
                        .stroke(Color.blue, lineWidth: 4)
                        .frame(width: 10 + CGFloat(index) * 20, height: 10 + CGFloat(index) * 20)
                        .opacity(Double(index) / 6.0)
                        .scaleEffect(scale)
                        .shadow(color: .blue, radius: 5)
                        .shadow(color: .blue, radius: 5)
                        .shadow(color: .blue, radius: 5)
                }
            }
            //Run Animation on "Start Breathing Session" Click
            .onChange(of: timeToRun, perform: { newValue in
                if newValue {
                    runAnimation()
                }
            })
            .onDisappear {
                //Return to Initial State
                breathsTaken = numberOfBreaths
                if timeManager.isRunning {
                    timeManager.startTimer()
                }
            }
        }
        
        //Breathing Instructions Text
        if timeToRun {
            Spacer()
            Text(breathText)
                .foregroundColor(.primary)
                .font(.system(.title, design: .rounded, weight: .light))
                .padding()
                .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.3)))
                .multilineTextAlignment(.center)
        }
    }
    
    //Breahing Animation and Instructions Logic
    func runAnimation() {
        guard numberOfBreaths == 0 || breathsTaken < numberOfBreaths else {
            withAnimation(Animation.easeInOut(duration: 3)) {
                timeToRun = false
                blur = 0
                animate = true
                rotation += 360
                scale = 2
            }
            return
        }
        switch animationPhase {
        case .start:
            withAnimation {
                breathText = "Settle in a comfortable position"
            }
            withAnimation(Animation.easeInOut(duration: 3)) {
                animate = false
                scale = 1
                blur = 50
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(Animation.easeInOut(duration: 3)) {
                    animate = true
                    scale = 2
                }
                withAnimation {
                    breathText = "Think about a place that makes you feel happy"
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                withAnimation {
                    breathText = "And Relax 🧘"
                }
                withAnimation(Animation.easeInOut(duration: 3)) {
                    animate = false
                    scale = 1
                    blur = 20
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                withAnimation {
                    breathText = " "
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                animationPhase = .breatheIn
                runAnimation()
            }
        case .breatheIn:
            withAnimation(Animation.easeInOut(duration: breatheInDuration)) {
                blur = 0
                animate = true
                rotation += 360
                scale = 2
            }
            withAnimation{
                breathText = "Inhale ↑"
            }
            HapticManager.generateHaptic()
            DispatchQueue.main.asyncAfter(deadline: .now() + breatheInDuration) {
                animationPhase = .holdIn
                runAnimation()
            }
        case .holdIn:
            withAnimation{
                breathText = "Hold"
            }
            HoldBreathHapticManager.generateHaptic()
            DispatchQueue.main.asyncAfter(deadline: .now() + holdInDuration) {
                animationPhase = .breatheOut
                runAnimation()
            }
        case .breatheOut:
            withAnimation(Animation.easeInOut(duration: breatheOutDuration)) {
                animate = false
                scale = 1
                blur = 20
            }
            withAnimation{
                breathText = "Exhale ↓"
            }
            HapticManager.generateHaptic()
            DispatchQueue.main.asyncAfter(deadline: .now() + breatheOutDuration) {
                animationPhase = .holdOut
                runAnimation()
            }
        case .holdOut:
            withAnimation{
                breathText = "Hold"
            }
            HoldBreathHapticManager.generateHaptic()
            DispatchQueue.main.asyncAfter(deadline: .now() + holdOutDuration) {
                breathsTaken += 1
                animationPhase = .breatheIn
                runAnimation()
            }
        }
    }
}

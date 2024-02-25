//
//  BreathingTechniqueSheetView.swift
//  Foco
//
//  Created by João Franco on 29/01/2024.
//

import SwiftUI

struct BreathScreen: View {
    //Sheets
    @State private var isShowingBreathAnimationStyleSheet = false
    @State private var isShowingBreathingTechniqueSheet = false

    //Animation Properties
    @AppStorage("breathAnimation") private var breathAnimation: BreathingAnimationStyle = .flower
    @State private var animate = true
    @State private var breathsTaken = 0
    @State private var animationPhase: AnimationPhase = .start
    @State private var isRunning: Bool = false
    
    //Breathing Pattern Properties
    @State private var selectedBreathingTechnique: BreathingTechnique = .boxBreathing
    @AppStorage("numberOfBreaths") private var numberOfBreaths = 1
    @State private var breathDuration = 4.0
    @State private var remainingTime: Double = 0.0
    
    //Controllers
    @EnvironmentObject var timeManager: TimerController
    
    // Computed property for session time formatted
    var sessionTimeFormatted: String {
        let totalTimePerCycle = selectedBreathingTechnique.parameters.breatheInDuration +
                                selectedBreathingTechnique.parameters.breatheOutDuration +
                                selectedBreathingTechnique.parameters.holdInDuration +
                                selectedBreathingTechnique.parameters.holdOutDuration
        
        let totalSessionTimeInSeconds = totalTimePerCycle * Double(numberOfBreaths) + 9
        
        let minutes = Int(totalSessionTimeInSeconds) / 60
        let seconds = Int(totalSessionTimeInSeconds) % 60
        
        if minutes == 1 && seconds == 1 {
            return "\(minutes) minute and \(seconds) second"
        } else if minutes == 1 {
            return "\(minutes) minute and \(seconds) seconds"
        } else if seconds == 1 {
            return "\(minutes) minutes and \(seconds) second"
        } else if minutes == 0 {
            return "\(seconds) seconds"
        } else {
            return "\(minutes) minutes and \(seconds) seconds"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                BreathAnimation(animationStyle: breathAnimation, timeToRun: $isRunning, animate: $animate, animationPhase: $animationPhase, breatheInDuration: selectedBreathingTechnique.parameters.breatheInDuration, breatheOutDuration: selectedBreathingTechnique.parameters.breatheOutDuration, holdInDuration: selectedBreathingTechnique.parameters.holdInDuration, holdOutDuration: selectedBreathingTechnique.parameters.holdOutDuration, numberOfBreaths: numberOfBreaths, breathsTaken: $breathsTaken)
                
                if !isRunning {
                    Spacer()
                    Button(action: triggerAnimation) {
                        HStack{
                        Image(systemName: "sparkles")
                            .imageScale(.large)
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(.black)
                        Text("Start Breathing Session")
                            .foregroundColor(.primary)
                        }
                    }.buttonStyle(PressEffectButtonStyle())
                    .padding()
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 70)
            .navigationTitle("\(sessionTimeFormatted) Breathing Session")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !isRunning {
                    ToolbarItemGroup(placement: .automatic) {
                        Button {
                            self.isShowingBreathAnimationStyleSheet = true
                        } label: {
                            Image(systemName: "paintpalette.fill")
                        }
                        .sheet(isPresented: $isShowingBreathAnimationStyleSheet) {
                            BreathAnimationStyleSheet(isShowingPopover: $isShowingBreathAnimationStyleSheet, breathAnimation: $breathAnimation)
                        }
                        VStack(){
                            Button {
                                self.isShowingBreathingTechniqueSheet = true
                            } label: {
                                Image(systemName: "gear")
                            }
                        }
                        .sheet(isPresented: $isShowingBreathingTechniqueSheet) {
                            BreathingTechniqueSheetView( selectedBreathingTechnique: $selectedBreathingTechnique, numberOfBreaths: $numberOfBreaths)
                        }
                    }
                }
            }
        }
        
    }
    
    func triggerAnimation() {
        animate = true
        withAnimation {
            isRunning.toggle()
        }
        breathsTaken = 0
        animationPhase = .start
    }
}

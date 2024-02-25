//
//  PomodoroScreen.swift
//  Foco
//
//  Created by João Franco on 01/02/2024.
//

import SwiftUI
import TipKit

struct TimerView: View {
    //Environment Variables
    @Environment(\.colorScheme) var colorScheme
    //Settings Sheet
    @State private var showingSettingsSheet = false
    //Stop Timer Alert
    @State private var showingAlert = false
    
    //Global Timer
    @EnvironmentObject var timeManager: TimerController
    
    //Tips
    private let breathTip = BreathTip()
    
    var backgroundGradient: LinearGradient {
        colorScheme == .dark ?
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 143/255, green: 127/255, blue: 101/255),
                Color(red: 44/255, green: 31/255, blue: 8/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ) :
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 255/255, green: 253/255, blue: 254/255),
                Color(red: 189/255, green: 183/255, blue: 173/255)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        NavigationStack() {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack{
                            HStack {
                                //Settings Button
                                if !timeManager.hasStarted {
                                    Button(action: {
                                        showingSettingsSheet.toggle()
                                    }) {
                                        HStack {
                                            Text(timeManager.timerType == 0 ? "Pomodoro" : "Flow")
                                            Divider().frame(height: 20).clipped()
                                            if timeManager.timerType == 0 {
                                                Text("\(Int(timeManager.workSessionDuration)) min")
                                                    .foregroundColor(.primary)
                                            } else {
                                                Text("\(Int(timeManager.flowDuration)) min")
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                    }
                                    .sheet(isPresented: $showingSettingsSheet) {
                                        TimerSettingsSheetView(workSessionDuration: $timeManager.workSessionDuration,
                                                               shortBreakDuration: $timeManager.shortBreakDuration,
                                                               longBreakDuration: $timeManager.longBreakDuration,
                                                               remainingTime: $timeManager.remainingTime,
                                                               timerType: $timeManager.timerType,
                                                               flowDuration: $timeManager.flowDuration)
                                    }
                                    .buttonStyle(PressEffectButtonStyle())
                                }
                            }
                            //Show tip if iOS17 >=
                            if #available(iOS 17.0, *) {
                                //BreathScreen
                                HStack {
                                    NavigationLink {
                                        // destination view to navigation to
                                        BreathScreen()
                                    } label: {
                                        HStack {
                                            Image(systemName: "sos")
                                        }
                                    }
                                    .buttonStyle(PressEffectIconButtonStyle())
                                    .popoverTip(breathTip, arrowEdge: .top)
                                }
                            } else {
                                //BreathScreen
                                HStack {
                                    NavigationLink {
                                        // destination view to navigation to
                                        BreathScreen()
                                    } label: {
                                        HStack {
                                            Image(systemName: "sos")
                                        }
                                    }
                                    .buttonStyle(PressEffectIconButtonStyle())
                                }
                            }
                        }
                        Spacer()
                        
                        //Time
                        ZStack {
                            Text(timeManager.timeFormatted())
                                .font(.system(size: 70, weight: .semibold, design: .default))
                        }
                        .padding()
                        
                        Spacer()
                        
                        //Control Buttons
                        HStack {
                            if !timeManager.hasStarted {
                                Button(action: {
                                    timeManager.startTimer()
                                }) {
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .imageScale(.large)
                                            .foregroundColor(.primary)
                                        Text("Start Study Session")
                                            .foregroundColor(.primary)
                                    }
                                }
                                .buttonStyle(PressEffectButtonStyle())
                            } else {
                                Button(action: {
                                    showingAlert.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "gobackward")
                                            .imageScale(.large)
                                            .foregroundColor(.primary)
                                        Text("Restart")
                                            .foregroundColor(.primary)
                                    }
                                }
                                .buttonStyle(PressEffectButtonStyle())
                                .alert("Stop the Timer?", isPresented: $showingAlert) {
                                    Button("Cancel", role: .cancel) {}
                                    Button("Stop", role: .destructive) {
                                        timeManager.stopTimer()
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 70)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .clipped()
                }
            }
            .onChange(of: timeManager.workSessionDuration) { newWorkSessionDuration in
                if timeManager.timerType == 0 {
                    timeManager.remainingTime = newWorkSessionDuration * 60
                }
            }
            .onChange(of: timeManager.flowDuration) { newFlowDuration in
                if timeManager.timerType == 1 {
                    timeManager.remainingTime = newFlowDuration * 60
                }
            }
            .onChange(of: timeManager.timerType) { newTimerType in
                timeManager.updateRemainingTime(for: newTimerType)
            }
        }
    }
}

#Preview {
    TimerView()
}

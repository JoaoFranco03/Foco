//
//  SettingsSheetView.swift
//
//
//  Created by João Franco on 05/02/2024.
//

import SwiftUI

struct TimerSettingsSheetView: View {
    //Environment Variables
    @Environment(\.dismiss) var dismiss
    
    //Values to Change
    @Binding var workSessionDuration: TimeInterval
    @Binding var shortBreakDuration: TimeInterval
    @Binding var longBreakDuration: TimeInterval
    @Binding var remainingTime: TimeInterval
    @Binding var timerType: Int
    @State var useDefaultPomodoro: Bool = true
    @State var useBreakReminder: Bool = false
    @Binding var flowDuration: TimeInterval

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //Pomodoro / Flow
                    Section(header: Text("Study Method")) {
                        Picker("What is the Timer Type?", selection: $timerType) {
                            Text("Pomodoro").tag(0)
                            Text("Flow").tag(1)
                        }
                        .pickerStyle(.segmented)
                    }
                    if timerType == 0 {
                        Section(header: Text("Description")) {
                            Text("The Pomodoro Technique is a time management method that involves working in short intervals (typically 25 minutes) called 'Pomodoros', followed by brief breaks. After completing four Pomodoros, take a longer break. This technique aims to enhance focus and productivity.")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                        }
                        Section(header: Text("Preferences")) {
                            Toggle(isOn: $useDefaultPomodoro, label: {
                                Text("Use Default Values")
                                    .foregroundStyle(.primary)
                            })
                        }
                        Section(header: Text("🎯 Work Session Duration: \(Int(workSessionDuration)) minutes")) {
                            Slider(value: $workSessionDuration, in: 1...60, step: 1)
                                .tint(Color.primary)
                                .disabled(useDefaultPomodoro)
                        }
                        
                        
                        Section(header: Text("😎 Short Break Duration: \(Int(shortBreakDuration)) minutes")) {
                            Slider(value: $shortBreakDuration, in: 1...15, step: 1)
                                .tint(Color.primary)
                                .disabled(useDefaultPomodoro)
                        }
                        Section(header: Text("😴 Long Break Duration: \(Int(longBreakDuration)) minutes")) {
                            Slider(value: $longBreakDuration, in: 1...30, step: 1)
                                .tint(Color.primary)
                                .disabled(useDefaultPomodoro)
                        }
                    } else {
                        Section(header: Text("Description")) {
                            Text("The Flowtime Technique harnesses the power of 90-minute, undistracted work sessions, aiming for the state of 'flow'. After each focused block, a short break ensures renewal before diving into the next task. This method optimizes productivity and work quality by aligning with individual attention rhythms.")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                        }
                        Section(header: Text("Flow Duration: \(Int(flowDuration)) minutes")) {
                            Slider(value: $flowDuration, in: 1...120, step: 1)
                                .tint(Color.primary)
                        }
                        
                    }
                }
                    .navigationTitle("Timer Settings")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.primary)
                            })
                        }
                    })
            }
        }
    }
}

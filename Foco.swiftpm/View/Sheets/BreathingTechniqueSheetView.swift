//
//  BreathingTechniqueSheetView.swift
//
//
//  Created by João Franco on 05/02/2024.
//

import SwiftUI

struct BreathingTechniqueSheetView: View {
    //Environment Variables
    @Environment(\.dismiss) var dismiss
    
    //Breathing Variables
    @Binding var selectedBreathingTechnique: BreathingTechnique
    @Binding var numberOfBreaths: Int
    
    //Formatted Time for Header of View
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
        NavigationStack(){
            VStack {
                Form{
                    //Number of Breath
                    Stepper("Number of Breaths: **\(numberOfBreaths)**", value: $numberOfBreaths, in: 1...20)
                    
                    //Breathing Pattern
                    Section(header: Text("Choose a Breahing Pattern")) {
                        Picker("Breahing Pattern", selection: $selectedBreathingTechnique) {
                            ForEach(BreathingTechnique.allCases, id: \.self) { technique in
                                Text(technique.name)
                                    .tag(technique)
                            }
                        }
                        HStack{
                            Text("Breathing Session Duration:")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text(sessionTimeFormatted)
                                .font(.callout).bold()
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    //Description of Breathing Pattern
                    Section(header: Text("Description")) {
                        Text(selectedBreathingTechnique.description)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                    }
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .toolbar(content: {
                    //Dismiss
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

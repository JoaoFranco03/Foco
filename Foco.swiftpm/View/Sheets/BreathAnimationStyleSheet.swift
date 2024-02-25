//
//  BreathAnimationStyleSheet.swift
//
//
//  Created by João Franco on 05/02/2024.
//

import SwiftUI

struct BreathAnimationStyleSheet: View {
    //Environment Variables (Dismiss)
    @Environment(\.dismiss) var dismiss
    
    //Sheets
    @Binding var isShowingPopover: Bool
    
    //Parameters
    @Binding var breathAnimation: BreathingAnimationStyle
    
    var body: some View {
        NavigationStack(){
            VStack(){
                Form{
                    //Styke
                    Section(header: Text("Choose a Style:")) {
                        Picker("Style", selection: $breathAnimation) {
                            ForEach(BreathingAnimationStyle.allCases, id: \.self) { animation in
                                Text(animation.name)
                                    .tag(animation)
                            }
                        }
                    }
                    
                    //Visual Preview of Style
                    Section(header: Text("Preview")) {
                        breathAnimation.preview
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
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

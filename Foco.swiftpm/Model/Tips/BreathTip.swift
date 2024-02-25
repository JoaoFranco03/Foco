//
//  BreathTip.swift
//
//
//  Created by João Franco on 05/02/2024.
//

import Foundation
import SwiftUI
import TipKit

struct BreathTip: Tip {
    var id = UUID()
    var title: Text {
        Text("Take a Breath")  // Adjusted for pin button and Breath Screen
    }
    
    var message: Text? {
        Text("Feeling stressed or overwhelmed? Tap here for a mindful breathing exercise.") // Adjusted for Breath Screen
    }
}

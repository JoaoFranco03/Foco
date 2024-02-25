//
//  CircleProgressBar.swift
//  
//
//  Created by João Franco on 25/02/2024.
//

import Foundation
import SwiftUI

struct CircleProgressBar: View {
    var current: Double
    var goal: Double
    
    var progress: Double {
        guard goal > 0 else {
            return 0
        }

        return min(1.0, Double(current) / Double(goal))
    }

    var body: some View {
        Circle()
            .stroke(Color(.systemBackground).opacity(0.3), lineWidth: 10)
            .overlay(
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .rotation(.degrees(180))
                    .stroke(Color(red: 237/255, green: 106/255, blue: 208/255), lineWidth: 10)
            )
            .overlay(Text("\(Int(current)) of \(Int(goal)) minutes")
                .font(.title).bold()
            )
            .frame(maxWidth: 300)
    }
}

//
//  BreathingAnimationStyle.swift
//  Foco
//
//  Created by João Franco on 05/02/2024.
//

import Foundation
import SwiftUI

enum BreathingAnimationStyle: String, CaseIterable, Hashable, Identifiable {
    case flower, orb, rings
    
    var id: String { rawValue }
    
    var name: String {
        switch self {
        case .flower:
            return "Flower"
        case .orb:
            return "Orb"
        case .rings:
            return "Rings"
        }
    }
    
    //For Breath Style Sheet
    var preview: some View {
        switch self {
        case .flower:
            return AnyView(
                HStack{
                    Spacer()
                    ZStack {
                        ForEach(0..<12) { i in
                            let angle = 2 * .pi / 12 * Double(i)
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.teal, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .scaleEffect(2)
                                .opacity(0.2)
                                .frame(width: 80, height: 80)
                                .offset(x: CGFloat(cos(angle)) * 70,
                                        y: CGFloat(sin(angle)) * 70)
                        }
                    }
                    .frame(width: 275, height: 275)
                    .padding()
                    Spacer()
                }
                .listRowBackground(Color(.systemBackground))
            )
        case .orb:
            return AnyView(
                HStack{
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .bottom, endPoint: .top))
                            .frame(width: 200, height: 200)
                            .blur(radius: 15)
                            .opacity(0.5)
                    }
                    .padding()
                    Spacer()
                }
                .listRowBackground(Color(.systemBackground))
            )
        case .rings:
            return AnyView(
                HStack{
                    Spacer()
                    ZStack {
                        ForEach(1...5, id: \.self) { index in
                            Circle()
                                .stroke(Color.blue, lineWidth: 4)
                                .frame(width: 20 + CGFloat(index) * 40, height: 20 + CGFloat(index) * 40)
                                .opacity(Double(index) / 6.0)
                                .scaleEffect(1)
                                .shadow(color: .blue, radius: 5)
                                .shadow(color: .blue, radius: 5)
                                .shadow(color: .blue, radius: 5)
                        }
                    }
                    .padding()
                    Spacer()
                }
                .listRowBackground(Color(.systemBackground))
            )
        }
    }
}

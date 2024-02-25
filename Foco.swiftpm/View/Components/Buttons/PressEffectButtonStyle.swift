//
//  PressEffectButtonStyle.swift
//
//
//  Created by João Franco on 10/02/2024.
//

import SwiftUI

struct PressEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding(.horizontal)
            .background(Material.bar)
            .mask(Capsule())
            .overlay(
                Capsule()                    .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
            .shadow(color: Color(.black).opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

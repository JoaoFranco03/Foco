//
//  CustomTabItem.swift
//
//
//  Created by João Franco on 25/02/2024.
//

import Foundation
import SwiftUI

extension ContentView{
    func CustomTabItem(imageName: String, title: String, color: Color, isActive: Bool) -> some View{
        HStack(spacing: 0) {
            if horizontalSizeClass == .compact {
                Image(systemName: imageName)
                    .foregroundColor(isActive ? color : .secondary)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(isActive ? AnyShapeStyle(Material.regular) : AnyShapeStyle(.clear))
                    .clipShape(Capsule())
                    .background(
                        Capsule()
                            .stroke(LinearGradient(colors: isActive ? [.white.opacity(0.2), .white.opacity(0.1)] : [Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                    )
            } else {
                HStack{
                    Image(systemName: imageName)
                    Text(title).bold()
                }
                .foregroundColor(isActive ? color : .secondary)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(isActive ? AnyShapeStyle(Material.regular) : AnyShapeStyle(.clear))
                .clipShape(Capsule())
                .background(
                    Capsule()
                        .stroke(LinearGradient(colors: isActive ? [.white.opacity(0.2), .white.opacity(0.1)] : [Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                )
                .onAppear {
                    withAnimation {
                        isTapped.toggle()
                    }
                }
            }
        }
    }
}

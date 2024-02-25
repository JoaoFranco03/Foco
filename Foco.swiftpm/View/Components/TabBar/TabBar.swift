//
//  TabBar.swift
//
//
//  Created by João Franco on 10/02/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case clock
    case breath
}

struct TabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? Color.accentColor : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: 60)
            .background(.ultraThinMaterial)
            .mask(Capsule())
            .overlay(
                Capsule()                    
                    .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
            )
            .padding()
        }
    }
}

#Preview {
    TabBar(selectedTab: .constant(.house))
}

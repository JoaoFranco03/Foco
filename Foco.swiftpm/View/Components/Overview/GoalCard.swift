//
//  GoalCard.swift
//
//
//  Created by João Franco on 25/02/2024.
//

import Foundation
import SwiftUI

struct GoalCard: View {
    @State private var isShowingSheet = false
    @EnvironmentObject var timerController: TimerController
    var body: some View {
        VStack{
            HStack{
                Text("Weekly Study Minutes Goal")
                    .font(.title3).bold()
                Spacer()
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Image(systemName: "pencil")
                }
                .foregroundStyle(Color.primary)
            }
            .padding()
            CircleProgressBar(current: timerController.weeklyGoalMinutesCount, goal: timerController.weeklyGoal)
                .padding()
        }
        .sheet(isPresented: $isShowingSheet) {
            EditWeeklyGoalSheet(weeklyGoal: $timerController.weeklyGoal)
        }
        .background(Material.ultraThin)
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
        )
        .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

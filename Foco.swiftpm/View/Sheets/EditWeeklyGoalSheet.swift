//
//  EditWeeklyGoalSheet.swift
//
//
//  Created by João Franco on 25/02/2024.
//

import SwiftUI

struct EditWeeklyGoalSheet: View {
    @Binding var weeklyGoal: Double // Change to Double
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                //Goal
                Section(header: Text("Weekly **\(Int(weeklyGoal))** Minutes Study Goal")) {
                    Slider(value: $weeklyGoal, in: 10...1000, step: 10)
                        .tint(Color.primary)
                }
            }
            .navigationTitle("Edit Goal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Go Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}


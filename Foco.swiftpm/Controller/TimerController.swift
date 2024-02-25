//
//  TimeManager.swift
//
//
//  Created by João Franco on 16/02/2024.
//

import Foundation
import SwiftUI

class TimerController: ObservableObject {
    // Timer properties
    private var timer: Timer?
    private var sessionCount = 1
    @Published var hasStarted = false
    @Published var isRunning = false
    @Published var remainingTime: TimeInterval = 25 * 60
    @Published var workSessionDuration: TimeInterval = 25
    @Published var shortBreakDuration: TimeInterval = 5
    @Published var longBreakDuration: TimeInterval = 15
    @Published var timerType: Int = 0
    @Published var flowDuration: TimeInterval = 90
    @Published var currentDuration: TimeInterval = 0
    @Published var weeklyGoal: Double = 360 {
        didSet {
            UserDefaults.standard.set(weeklyGoal, forKey: "weeklyGoal")
        }
    }
    @Published var weeklyGoalMinutesCount: Double = 0 {
        didSet {
            // Save weeklyGoalMinutesCount to UserDefaults
            UserDefaults.standard.set(weeklyGoalMinutesCount, forKey: "weeklyGoalMinutesCount")
        }
    }
    
    init() {
        checkNewWeek()
        loadWeeklyGoal()
        loadWeeklyGoalMinutesCount()
    }
    
    //Timer Functions
    func checkNewWeek() {
        let calendar = Calendar.current
        let now = Date()
        
        let currentWeek = calendar.component(.weekOfYear, from: now)
        let currentYear = calendar.component(.year, from: now)
        
        let lastWeek = UserDefaults.standard.integer(forKey: "lastWeek")
        let lastYear = UserDefaults.standard.integer(forKey: "lastYear")
        
        if currentWeek != lastWeek || currentYear != lastYear {
            weeklyGoalMinutesCount = 0
            UserDefaults.standard.set(currentWeek, forKey: "lastWeek")
            UserDefaults.standard.set(currentYear, forKey: "lastYear")
        }
    }
    
    func loadWeeklyGoal() {
        if let savedGoal = UserDefaults.standard.object(forKey: "weeklyGoal") as? Double {
            weeklyGoal = savedGoal
        } else {
            weeklyGoal = 360
        }
    }
    
    func loadWeeklyGoalMinutesCount() {
        weeklyGoalMinutesCount = UserDefaults.standard.double(forKey: "weeklyGoalMinutesCount")
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopTimer()
                if self.timerType == 0 {
                    self.handlePomodoroTimerCompletion()
                }
                self.addToWeeklyGoal(minutes: self.currentDuration / 60)
            }
            self.currentDuration += 1
        }
        withAnimation {
            hasStarted = true
            isRunning = true
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        remainingTime = workSessionDuration * 60
        withAnimation {
            hasStarted = false
            isRunning = false
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        withAnimation {
            isRunning = false
        }
    }
    
    func timeFormatted() -> String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func handlePomodoroTimerCompletion() {
        sessionCount += 1
        
        switch sessionCount {
        case 1, 3, 5, 7: // Work sessions
            remainingTime = workSessionDuration * 60
        case 2, 4, 6: // Short breaks
            remainingTime = shortBreakDuration * 60
        case 8: // Long break after 4 cycles
            remainingTime = longBreakDuration * 60
            sessionCount = 0 // Reset session count
        default:
            fatalError("Invalid session count")
        }
        startTimer()
    }
    
    func updateRemainingTime(for timerType: Int) {
        sessionCount = 1 // Reset session count
        
        switch timerType {
        case 0:
            remainingTime = workSessionDuration * 60
        case 1:
            remainingTime = flowDuration * 60
        default:
            fatalError("Invalid timerType")
        }
    }
    
    func updateWeeklyGoal(newGoalMinutes: Double) {
        weeklyGoal = newGoalMinutes
    }
    
    func addToWeeklyGoal(minutes: Double) {
        weeklyGoalMinutesCount += minutes
    }
}

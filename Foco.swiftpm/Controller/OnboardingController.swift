//
//  OnboardingController.swift
//
//
//  Created by João Franco on 25/02/2024.
//

import UIKit
import SwiftUI
class OnboardingController: ObservableObject {
    @Published var showOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(showOnboarding, forKey: "showOnboarding")
        }
    }
    
    init() {
        if UserDefaults.standard.object(forKey: "showOnboarding") == nil {
            self.showOnboarding = true
        } else {
            self.showOnboarding = UserDefaults.standard.bool(forKey: "showOnboarding")
        }
    }
    
    //CRUD Function
    func setShowOnboarding(_ show: Bool) {
        showOnboarding = show
        objectWillChange.send()
    }
}

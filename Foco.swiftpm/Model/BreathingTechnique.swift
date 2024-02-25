//
//  BreathingTechnique.swift
//  Foco
//
//  Created by João Franco on 31/01/2024.
//

import Foundation

enum BreathingTechnique: CaseIterable, Hashable {
    case boxBreathing
    case sevenEightBreathing
    case equalBreathing
    case diaphragmaticBreathing

    var name: String {
        switch self {
        case .boxBreathing:
            return "Box Breathing"
        case .sevenEightBreathing:
            return "4-7-8 Breathing"
        case .equalBreathing:
            return "Equal Breathing"
        case .diaphragmaticBreathing:
            return "Diaphragmatic Breathing"
        }
    }

    var description: String {
        switch self {
        case .boxBreathing:
            return "Box Breathing, also known as Square Breathing, is a simple yet effective technique to manage stress and anxiety. By inhaling, holding, exhaling, and holding the breath in equal counts, this method helps promote relaxation and balance in the nervous system."
        case .sevenEightBreathing:
            return "The 4-7-8 Breathing Technique is designed to induce calmness and aid in falling asleep faster. Inhale for a count of 4, hold the breath for 7 seconds, and exhale slowly for 8 seconds. This method helps regulate breathing and promotes a sense of tranquility."
        case .equalBreathing:
            return "Equal Breathing, or Sama Vritti in yogic terms, focuses on balancing the inhale and exhale durations. This technique helps center the mind, enhance concentration, and promote a sense of overall well-being."
        case .diaphragmaticBreathing:
            return "Diaphragmatic Breathing, also known as belly breathing, emphasizes deep breaths that engage the diaphragm. This technique helps reduce stress, enhance oxygenation, and promote a calm and centered state of mind."
        }
    }

    var parameters: (breatheInDuration: Double, breatheOutDuration: Double, holdInDuration: Double, holdOutDuration: Double) {
        switch self {
        case .boxBreathing:
            return (4, 4, 4, 4)
        case .sevenEightBreathing:
            return (4, 8, 7, 2)
        case .equalBreathing:
            return (5, 5, 5, 5)
        case .diaphragmaticBreathing:
            return (6, 6, 2, 2)
        }
    }
}

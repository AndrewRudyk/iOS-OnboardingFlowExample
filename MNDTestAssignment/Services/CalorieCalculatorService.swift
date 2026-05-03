//
//  CalorieCalculatorService.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

protocol CalorieCalculating {
    func calculateEER(gender: Gender, age: Int, weightKg: Double, heightMeters: Double) -> Double
}

final class CalorieCalculatorService: CalorieCalculating {
    
    private let defaultPA: Double = 1.0 // PA (Physical Activity)
    
    func calculateEER(gender: Gender, age: Int, weightKg: Double, heightMeters: Double) -> Double {
        switch gender {
        case .male:
            return 662 - (9.53 * Double(age)) + defaultPA * (15.91 * weightKg + 539.6 * heightMeters)
        case .female:
            return 354 - (6.91 * Double(age)) + defaultPA * (9.36 * weightKg + 726 * heightMeters)
        }
    }
}

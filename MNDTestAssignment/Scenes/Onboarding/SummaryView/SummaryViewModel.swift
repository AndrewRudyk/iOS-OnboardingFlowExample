//
//  SummaryViewModel.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

final class SummaryViewModel: ObservableObject {
    @Published var budgetDisplayValue: String = ""
    @Published var unitLabel: String = ""
    
    private let onFinish: () -> Void
    
    private let calculator: CalorieCalculating
    private let session: UserSession
    
    init(session: UserSession, calculator: CalorieCalculating = CalorieCalculatorService(), onFinish: @escaping () -> Void) {
        self.session = session
        self.calculator = calculator
        self.onFinish = onFinish
        calculate()
    }
    
    private func calculate() {
        let calendar = Calendar.current
        let age = calendar.dateComponents([.year], from: session.dateOfBirth ?? Date(), to: .now).year ?? 0
        
        let calories = calculator.calculateEER(
            gender: session.gender ?? .male,
            age: age,
            weightKg: session.weightKg ?? 0,
            heightMeters: session.heightMeters ?? AppConfig.Onboarding.defaultHeightMeters
        )
        
        if (session.isMetric ?? AppConfig.Onboarding.defaultMetricState) {
            let kj = calories * AppConfig.Health.kcalToKjMultiplier
            budgetDisplayValue = String(format: "%.0f", kj)
            unitLabel = "kJ / day"
        } else {
            budgetDisplayValue = String(format: "%.0f", calories)
            unitLabel = "kcal / day"
        }
    }
    
    
    // MARK: - Actions
    
    func nextStep() {
        onFinish()
    }
}

//
//  DateOfBirthViewModel.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

final class DateOfBirthViewModel: ObservableObject {
    @Published var selectedDate: Date {
        didSet {
            validateAge()
        }
    }
    
    @Published var isNextButtonDisabled: Bool = true
    
    private let onFinish: (Date) -> Void
    private let calendar = Calendar.current
    
    
    init(initialDate: Date?, onFinish: @escaping (Date) -> Void) {
        let defaultDate = calendar.date(byAdding: .year, value: -AppConfig.Onboarding.minimumAgeYears, to: Date()) ?? Date()
        let date = initialDate ?? defaultDate
        
        self.selectedDate = date
        self.onFinish = onFinish
        
        validateAge()
    }
    
    private func validateAge() {
        let ageComponents = calendar.dateComponents([.year], from: selectedDate, to: Date())
        let age = ageComponents.year ?? 0
        isNextButtonDisabled = age < AppConfig.Onboarding.minimumAgeYears
    }
    
    
    // MARK: - Actions
    
    func nextStep() {
        if !isNextButtonDisabled {
            onFinish(selectedDate)
        }
    }
}

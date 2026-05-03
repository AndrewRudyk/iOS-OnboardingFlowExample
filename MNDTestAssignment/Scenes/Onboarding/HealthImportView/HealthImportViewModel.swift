//
//  HealthImportViewModel.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

final class HealthImportViewModel: ObservableObject {
    @Published var isProcessing = false
    
    private let healthService: HealthKitService
    var onDataReady: ((Double?, Date?, Double) -> Void)?
    var onSkip: (() -> Void)?
    
    init(healthService: HealthKitService) {
        self.healthService = healthService
    }
    
    private func handleResult(weight: Double?, dob: Date?, height: Double?) {
        DispatchQueue.main.async {
            self.isProcessing = false
            let finalHeight = height ?? AppConfig.Onboarding.defaultHeightMeters
            self.onDataReady?(weight, dob, finalHeight)
        }
    }
    
    
    // MARK: - Actions
    
    func importData() {
        isProcessing = true
        
        healthService.requestAuthorization { [weak self] granted in
            guard granted else {
                self?.handleResult(weight: nil, dob: nil, height: nil)
                return
            }
            
            self?.healthService.fetchProfileData { weight, dob, height in
                self?.handleResult(weight: weight, dob: dob, height: height)
            }
        }
    }
    
    func skip() {
        onSkip?()
    }
}

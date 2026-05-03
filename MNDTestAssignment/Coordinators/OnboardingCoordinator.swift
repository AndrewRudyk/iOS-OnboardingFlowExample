//
//  AppCoordinator.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import UIKit
import SwiftUI

protocol Coordinator {
    func start()
}

final class OnboardingCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let healthService = HealthKitService()
    
    private var session = UserSession()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showWelcome()
    }
    
    
    // MARK: - Onboarding Flow
    
    private func showWelcome() {
        let view = WelcomeView { [weak self] in
            self?.showGenderSelection()
        }
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showGenderSelection() {
        let view = GenderView { [weak self] selectedGender in
            self?.session.gender = selectedGender
            self?.showHealthImport()
        }
        
        push(view: view)
    }
    
    private func showHealthImport() {
        let vm = HealthImportViewModel(healthService: healthService)
        
        vm.onDataReady = { [weak self] weight, dob, height in
            self?.session.weightKg = weight
            self?.session.dateOfBirth = dob
            self?.session.heightMeters = height
            self?.showWeightEntry()
        }
        
        vm.onSkip = { [weak self] in
            self?.session.heightMeters = AppConfig.Onboarding.defaultHeightMeters
            self?.showWeightEntry()
        }
        
        push(view: HealthImportView(viewModel: vm))
    }
    
    private func showWeightEntry() {
        let isMetric = session.isMetric ?? AppConfig.Onboarding.defaultMetricState
        
        let vm = WeightViewModel(
            initialWeightKg: session.weightKg,
            isMetricDefault: isMetric
        ) { [weak self] weight, isMetric in
            self?.session.weightKg = weight
            self?.session.isMetric = isMetric
            self?.showDateOfBirthEntry()
        }
        
        push(view: WeightView(viewModel: vm))
    }
    
    private func showDateOfBirthEntry() {
        let vm = DateOfBirthViewModel(initialDate: session.dateOfBirth) { [weak self] selectedDate in
            self?.session.dateOfBirth = selectedDate
            self?.showSummary()
        }
        
        push(view: DateOfBirthView(viewModel: vm))
    }
    
    private func showSummary() {
        let calculator = CalorieCalculatorService()
        let vm = SummaryViewModel(session: self.session, calculator: calculator) {
            print("Onboarding is done!")
        }
        
        push(view: SummaryView(viewModel: vm))
    }


    // MARK: - Helper functions
    
    private func push<V: View>(view: V) {
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
    }
}

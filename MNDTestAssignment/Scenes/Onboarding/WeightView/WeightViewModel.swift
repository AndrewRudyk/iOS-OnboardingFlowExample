//
//  WeightViewModel.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

// NOTE: Per assignment requirements, Metric is enabled by default for en-US.
// In a real-world scenario, I would verify this with the BA/PO as it
// contradicts standard regional settings (US typically uses Imperial).
final class WeightViewModel: ObservableObject {
    @Published var weightInput: String = ""
    @Published var isMetric: Bool
    
    private let onFinish: (Double, Bool) -> Void
    private let numberFormatter: NumberFormatter
    
    init(
        initialWeightKg: Double?,
        isMetricDefault: Bool,
        numberFormatter: NumberFormatter = .weightFormatter,
        onFinish: @escaping (Double, Bool) -> Void
    ) {
        self.isMetric = isMetricDefault
        self.onFinish = onFinish
        self.numberFormatter = numberFormatter
        
        if let kgValue = initialWeightKg {
            setupInitialValue(kgValue)
        }
    }
    
    private func setupInitialValue(_ kgValue: Double) {
        let displayValue = isMetric ? kgValue : kgValue.kgToLbs
        weightInput = format(displayValue)
    }

    
    // MARK: - Actions
    
    func toggleUnit() {
        guard let currentValue = parseInput() else {
            isMetric.toggle()
            return
        }

        let newValue = isMetric ? currentValue.kgToLbs : currentValue.lbsToKg
        
        isMetric.toggle()
        weightInput = format(newValue)
    }
    
    func nextStep() {
        guard let value = parseInput() else { return }
        
        let finalWeightInKg = isMetric ? value : value.lbsToKg
        onFinish(finalWeightInKg, isMetric)
    }
    
    
    // MARK: - Helpers
    
    private func parseInput() -> Double? {
        numberFormatter.number(from: weightInput)?.doubleValue
    }
    
    private func format(_ value: Double) -> String {
        numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}

extension NumberFormatter {
    static var weightFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }
}

extension Double {
    var kgToLbs: Double { self * AppConfig.Health.kgToLbsMultiplier }
    var lbsToKg: Double { self / AppConfig.Health.kgToLbsMultiplier }
}


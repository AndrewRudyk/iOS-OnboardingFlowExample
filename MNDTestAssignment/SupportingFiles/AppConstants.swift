//
//  AppConstants.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

enum AppConfig {
    enum Onboarding {
        /// Default height in meters if HealthKit import fails or is skipped
        static let defaultHeightMeters: Double = 1.7
        
        /// Minimum user age required to proceed
        static let minimumAgeYears: Int = 13
        
        /// According to the assignment: ON (true) for en-US, otherwise OFF (false).
        /// Note: In a real-world scenario, the US uses the Imperial system (lbs),
        /// but we are following the provided requirements strictly.
        /// This should be clarified with stakeholders in a production environment.
        static var defaultMetricState: Bool {
            let region = Locale.current.region?.identifier ?? "US"
            let language = Locale.current.language.languageCode?.identifier ?? "en"
            let localeId = "\(language)-\(region)"
            
            return localeId == "en-US" // Returns true for US as per assignment requirements
        }
    }
    
    enum Health {
        /// Conversion factor from Kilocalories to Kilojoules
        static let kcalToKjMultiplier: Double = 4.184
        
        /// Conversion factor from Kilograms to Pounds
        static let kgToLbsMultiplier: Double = 2.20462
    }
}

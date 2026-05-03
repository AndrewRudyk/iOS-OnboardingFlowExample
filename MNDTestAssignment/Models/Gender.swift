//
//  Gender.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import Foundation

enum Gender: CaseIterable {
    case male, female
    
    var title: String {
        switch self {
        case .male: "Male"
        case .female: "Female"
        }
    }
}

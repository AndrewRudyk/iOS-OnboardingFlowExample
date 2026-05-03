//
//  CalorieCalculatorServiceTests.swift
//  MNDTestAssignmentTests
//
//  Created by Andrew on 01/05/2026.
//


import XCTest
@testable import MNDTestAssignment

final class CalorieCalculatorServiceTests: XCTestCase {
    
    private var sut: CalorieCalculatorService!
    
    override func setUp() {
        super.setUp()
        sut = CalorieCalculatorService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCalculateEER_ForMale_ReturnsCorrectValue() {
        // Given
        let gender = Gender.male
        let age = 30
        let weight = 80.0
        let height = 1.8
        // Calculation: 662 - (9.53 * 30) + 1.0 * (15.91 * 80 + 539.6 * 1.8)
        // 662 - 285.9 + (1272.8 + 971.28) = 2620.18
        let expectedResult = 2620.18
        
        // When
        let result = sut.calculateEER(gender: gender, age: age, weightKg: weight, heightMeters: height)
        
        // Then
        XCTAssertEqual(result, expectedResult, accuracy: 0.01)
    }
    
    func testCalculateEER_ForFemale_ReturnsCorrectValue() {
        // Given
        let gender = Gender.female
        let age = 25
        let weight = 60.0
        let height = 1.65
        // Calculation: 354 - (6.91 * 25) + 1.0 * (9.36 * 60 + 726 * 1.65)
        // 354 - 172.75 + (561.6 + 1197.9) = 1940.75
        let expectedResult = 1940.75
        
        // When
        let result = sut.calculateEER(gender: gender, age: age, weightKg: weight, heightMeters: height)
        
        // Then
        XCTAssertEqual(result, expectedResult, accuracy: 0.01)
    }
}

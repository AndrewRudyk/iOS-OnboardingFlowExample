//
//  HealthKitService.swift
//  MNDTestAssignment
//
//  Created by Andrew on 30/04/2026.
//

import HealthKit

import HealthKit

final class HealthKitService {
    private let healthStore = HKHealthStore()
    
    var isAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard isAvailable else {
            completion(false)
            return
        }
        
        let typesToRead: Set<HKObjectType> = Set([
            HKQuantityType.quantityType(forIdentifier: .bodyMass),
            HKQuantityType.quantityType(forIdentifier: .height),
            HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)
        ].compactMap { $0 })
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            completion(success && error == nil)
        }
    }
    
    func fetchProfileData(completion: @escaping (_ weight: Double?, _ dob: Date?, _ height: Double?) -> Void) {
        let group = DispatchGroup()
        
        var fetchedWeight: Double?
        var fetchedDOB: Date?
        var fetchedHeight: Double?
        
        group.enter()
        fetchMostRecentQuantity(for: .bodyMass) { quantity in
            fetchedWeight = quantity?.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            group.leave()
        }
        
        group.enter()
        fetchMostRecentQuantity(for: .height) { quantity in
            fetchedHeight = quantity?.doubleValue(for: .meter())
            group.leave()
        }
        
        group.enter()
        do {
            let components = try healthStore.dateOfBirthComponents()
            fetchedDOB = components.date
        } catch {
            print("HK Date of Birth error: \(error.localizedDescription)")
        }
        group.leave()
        
        group.notify(queue: .main) {
            completion(fetchedWeight, fetchedDOB, fetchedHeight)
        }
    }
    
    private func fetchMostRecentQuantity(for typeIdentifier: HKQuantityTypeIdentifier, completion: @escaping (HKQuantity?) -> Void) {
        guard let type = HKQuantityType.quantityType(forIdentifier: typeIdentifier) else {
            completion(nil)
            return
        }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: type, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, _ in
            let quantity = (samples?.first as? HKQuantitySample)?.quantity
            completion(quantity)
        }
        
        healthStore.execute(query)
    }
}

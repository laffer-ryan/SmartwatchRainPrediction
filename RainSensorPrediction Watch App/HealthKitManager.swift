//
//  HealthKitManager.swift
//  RainSensorPrediction Watch App
//
//  Created by Ryan Lafferty on 18/10/23.
//

import Foundation

import Foundation
import HealthKit
import WidgetKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    
    var healthStore = HKHealthStore()
    
    let now = Date();
    
    
    init() {
        requestAuthorization()
    }
    
    
    func requestAuthorization() {
        
        // this is to make sure User's Heath Data is Avaialble
        guard HKHealthStore.isHealthDataAvailable() else {
            print("health data not available!")
            return
        }
        
        
        // this is the type of data we will be reading from Health (e.g stepCount)
        let temperature = HKQuantityType.quantityType(forIdentifier: .waterTemperature)
        let temperatureToShare = HKQuantityType.quantityType(forIdentifier: .)
        

        // asking User's permission for their Health Data
        // note: toShare is set to nil since I'm not updating any data
        healthStore.requestAuthorization(toShare: nil, read: temperature) { success, error in
            if success {
                self.fetchAllData()
            } else {
                print("\(String(describing: error))")
            }
        }
    }
    
    func fetchTemperature() {
        
    }
}

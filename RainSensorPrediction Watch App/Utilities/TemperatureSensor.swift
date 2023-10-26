//
//  TemperatureSensor.swift
//  RainSensorPrediction Watch App
//
//  Created by Ryan Lafferty on 17/10/23.
//

import Foundation
import HealthKit


let healthStore = HKHealthStore()

if HKHealthStore.isHealthDataAvailable() {
    // get temperature
} else {
    console.log("health data is unavailable")
}







//healthStore.requestAuthorization(toShare: nil, read: Set([HKQuantityType.identifier(for: .bodyTemperature)])) { (success, error) in
//    if success {
//        // Permission granted
//    } else {
//        // Permission denied
//    }
//}
//
//let temperatureQuery = HKQuantitySampleQuery(type: HKQuantityType.identifier(for: .bodyTemperature), predicate: nil, limit: 1, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
//    if let sample = samples?.first {
//        // The latest temperature sample is available
//        let temperature = sample.quantity.doubleValue(for: HKUnit.degreeCelsius())
//
//        // Do something with the temperature
//    } else {
//        // No temperature samples available
//    }
//})
//
//healthStore.execute(temperatureQuery);

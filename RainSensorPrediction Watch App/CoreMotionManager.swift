//
//  CoreMotionManager.swift
//  RainSensorPrediction Watch App
//
//  Created by Ryan Lafferty on 18/10/23.
//

import SwiftUI
import CoreMotion

class CoreMotionManager: ObservableObject {
    private let pressureManager = CMRecordedPressureData();
    var alertItem: AlertItem?
    
    
    func getWeather() async throws -> Weather? {
        if CMRecordedPressureData.accessInstanceVariablesDirectly {
            var weather = Weather(
                barometerPressure: convertToHectoPascals(measurement: pressureManager.pressure).value,
                temperature: convertToCelsius(measurement: pressureManager.temperature).value,
                lastUpdate: pressureManager.startDate
            )
            return weather;
        } else {
            throw APError.invalidAuthorization
        }
    }
    
    func convertToCelsius(measurement: Measurement<UnitTemperature>) -> Measurement<UnitTemperature> {
        return measurement.converted(to: .celsius)
    }
    
    func convertToHectoPascals(measurement: Measurement<UnitPressure>) -> Measurement<UnitPressure> {
        return measurement.converted(to: .hectopascals)
    }
}

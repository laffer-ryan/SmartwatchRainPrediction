//
//  MLManager.swift
//  RainSensorPrediction Watch App
//
//  Created by Ryan Lafferty on 26/10/23.
//

import CoreML
import Foundation

class MLManager: ObservableObject {
    
    var alertItem: AlertItem?

    
    var temperature: Double;
    var pastTemperature: Double;
    var pressure: Double;
    var pastPressure: Double;
    
    init(alertItem: AlertItem? = nil, temperature: Double, pastTemperature: Double, pressure: Double, pastPressure: Double) {
        self.alertItem = alertItem
        self.temperature = temperature
        self.pastTemperature = pastTemperature
        self.pressure = pressure
        self.pastPressure = pastPressure
    }
    
    func calculateRainPercentage() async throws -> Double {
        do{
            let config = MLModelConfiguration()
            let model = try RandomForestModel(configuration: config)
            let tempPressure = calculateTempPressure()
            let changePressure = calculateChangePressure()
            let changeTemp = calculateChangeTemperature()
            let temperature = calculateTemperatureScaled()
            let pressure = calculatePressureScaled()
            
            
            let prediction = try model.prediction(temp: temperature,
                                                  pressure: pressure,
                                                  temp_pressure: tempPressure,
                                                  change_pressure: changePressure,
                                                  change_temp: changeTemp)
            return prediction.classProbability[1] ?? 0
        } catch {
            throw APError.predictionError
        }
    }
    
    func calculateTemperatureScaled() -> Double {
        let median = 13.23 //derived from python notebook
        let iqr = 2.38   //derived from python notebook
        return ((temperature - median) / iqr)
    }

    func calculatePressureScaled() -> Double {
        let median = 1018.0 //derived from python notebook
        let iqr = 8.5   //derived from python notebook
        return ((pressure - median) / iqr)
    }
    
    func calculateTempPressure() -> Double {
        
        let MIN_VALUE: Double = 8.2
        var tempPressure: Double
        tempPressure = pressure / (temperature + MIN_VALUE)
        return tempPressure
    }
    
    func calculateChangePressure() -> Double {
        let newPressure = pastPressure - pressure
        return newPressure
    }
    
    func calculateChangeTemperature() -> Double {
        let newTemperature = pastTemperature - temperature
        return newTemperature
    }
}

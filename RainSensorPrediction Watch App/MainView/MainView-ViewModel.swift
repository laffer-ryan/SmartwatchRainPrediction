//
//  ContentView-ViewModel.swift
//  SmartRain Watch App
//
//  Created by Ryan Lafferty on 2/10/23.
//

import Foundation
import CoreML
import CoreMotion

@MainActor final class MainViewViewModel: ObservableObject {
    
    
    private let altimeter = CMAltimeter();
    @Published var alertItem: AlertItem?;
    @Published var isLoading = false;
    @Published var showingAlert = false;
    @Published var weather: Weather;
    
    @Published var currentTemperature: Double = 20.0;
    @Published var currentPressure: Double = 930.0;
    @Published var predictedTemperature: Double = 50.0;
    
    let coreMotionManager = CoreMotionManager();
    
    init() {
        weather = Weather(barometerPressure: 0.0, temperature: 0.0, lastUpdate: Date())
        getWeather();
    }
    
    
    func getWeather() {
        isLoading = true;
        Task{
            do {
                weather = try await coreMotionManager.getWeather() ?? Weather(barometerPressure: currentPressure, temperature: currentTemperature, lastUpdate: Date());
                isLoading = false
            } catch {
                isLoading = false
                print(error)
                throw APError.invalidResponse
                
            }
        }
    }
}
    
    
    
    
    
    
// Altimeter will be needed in the future when model data isn't limited
    
//    func myAltimeter(){
//        do{
//            if CMAltimeter.isAbsoluteAltitudeAvailable() {
//                altimeter.startAbsoluteAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitude, error) in
//                    if let altitude = altitude {
//                        let pressure = altitude.altitude
//                        print("Pressure: \(pressure)")
//                    }
//                })
//            } else {
//                alertItem = AlertContext.unavailableAltimeterData
//                isLoading = false
//            }
//        } catch {
//            alertItem = AlertContext.invalidAltimeterData
//            isLoading = false
//        }
//
//    }






//    var tempPressure: Double {
//        calculateTempPressure()
//    }
//    
//    var changePressure: Double {
//        calculateChangePressure()
//    }
//    
//    var changeTemperature: Double {
//        calculateChangeTemperature()
//    }
//    
//    
//    
//    @Published var weathers = [Weather] {
//        didSet {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(weathers) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//    init() {
//        let decoder = JSONDecoder()
//        if let savedWeather = UserDefaults.standard.data(forKey: "Items") {
//            if let decodedWeather = try? decoder.decode([Weather].self, from: savedWeather) {
//                weathers = decodedWeather
//                return
//            }
//        }
//        weathers = []
//    }
    
//    func predictTemperature() {
//        do {
//            let model: logisticRegressionModel = try logisticRegressionModel(configuration: .init())
//            
//            var predict = try model.prediction(
//                temp: Double(currentTemperature),
//                pressure: Double(currentPressure),
//                temp_pressure: Double(tempPressure),
//                change_pressure: Double(changePressure),
//                change_temp: Double(changeTemperature)
//            )
//            } catch {
//                alertItem = AlertContext.invalidResponse
//                showingAlert = true
//        }
//    }
//    
//    
//    func calculateTempPressure() -> Double {
//        
//        let MIN_VALUE: Double = 8.2
//        var tempPressure: Double
//        tempPressure = currentPressure / (currentTemperature + MIN_VALUE)
//        return tempPressure
//    }
//    
//    func calculateChangePressure() -> Double {
//        let newPressure = pastPressure - currentPressure
//        return newPressure
//    }
//    
//    func calculateChangeTemperature() -> Double {
//        let newTemperature = pastTemperature - currentTemperature
//        return newTemperature
//    }
//    



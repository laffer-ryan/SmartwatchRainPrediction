//
//  ContentView-ViewModel.swift
//  SmartRain Watch App
//
//  Created by Ryan Lafferty on 2/10/23.
//

import SwiftUI
import CoreML
import CoreMotion

@MainActor final class MainViewViewModel: ObservableObject {
    
    @AppStorage("previousWeather") private var storedWeather: Data?
    
    private let altimeter = CMAltimeter();
    @Published var alertItem: AlertItem? = nil;
    @Published var isLoading = false;
    @Published var showingAlert = false;
    @Published var prediction: Double = 0.0;
    
    @Published var weather = Weather();     // data from sensors
    @State var pastWeather = Weather();    // data from previous save function
    
    
    let coreMotionManager = CoreMotionManager();
    
    // accessing CoreMotion data which comes from sensor on request
    func getWeather() {
        Task {
            do {
                isLoading = true;
                //This will access the sensor data which is 0 and 0 at the moment
//                weather = try await coreMotionManager.getWeather() ?? Weather(barometerPressure: 0,
//                                                                              temperature: 0,
//                                                                              lastUpdate: Date());
                
                weather = Weather(barometerPressure: 900, temperature: 10, lastUpdate: Date());
                
                isLoading = false
            } catch {
                isLoading = false
                alertItem = AlertContext.invalidResponse
            }
        }
    }
    
    // get previously saved weather data from AppStorage and save it to pastWeather
    func fetchPastWeather() {
        guard let storedWeather = storedWeather else {return}
        
        do {
            pastWeather = try JSONDecoder().decode(Weather.self, from: storedWeather)
            saveWeather()
        } catch {
            alertItem = AlertContext.invalidWeatherData
        }
    }
    
    
    // save AppStorage data
    func saveWeather() {
        // Need to guard against saving incorrect data or within 30 minutes of the last saved data
        if (Date().timeIntervalSince(pastWeather.lastUpdate) > TimeInterval(30*60)) {
            do{
                let data = try JSONEncoder().encode(weather)
                storedWeather = data
            } catch {
                alertItem = AlertContext.invalidWeatherData
            }
            
        } else {
            storedWeather = storedWeather
        }
    }
    
    
    // prediction function to find the probability of rain
    func calculateRainPercentage() {
        Task {
            do{
                isLoading = true
                let mlManager = MLManager(temperature: weather.temperature, pastTemperature: pastWeather.temperature, pressure: weather.barometerPressure, pastPressure: pastWeather.barometerPressure);
                prediction = try await mlManager.calculateRainPercentage();
                isLoading = false
            } catch {
                isLoading = false
                throw APError.predictionError
            }
        }
    }
}




//    var isValidWeather: Bool {
//        guard   !weather.barometerPressure.isNaN && !weather.barometerPressure.isLess(than: 850) && !weather.barometerPressure > 1150 &&
//                !weather.temperature.isNaN && !weather.temperature.isLess(than: -30) && !weather.temperature > 45
//        else {
//            alertItem = AlertContext.invalidWeatherData
//            return false
//        }
//        guard (weather.lastUpdate - weather.lastUpdate) < TimeInterval(15*60) {
//            return false
//        }
//        return true
//    }


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




//    @Published var currentTemperature: Double = 20.0;
//    @Published var currentPressure: Double = 930.0;
//    @Published var predictedTemperature: Double = 50.0;






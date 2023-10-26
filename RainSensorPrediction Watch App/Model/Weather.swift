//
//  Attributes.swift
//  SmartRain Watch App
//
//  Created by Ryan Lafferty on 2/10/23.
//

import Foundation

struct Weather: Identifiable, Codable {
    var id = UUID()
    let barometerPressure: Double
    let temperature: Double
    let lastUpdate: Date
    
    
}


//#if DEBUG
//extension Weather {
//    static var example: Weather {
//        Weather(barometerPressure: 198.8,
//                temperature: 20,
//                percentChanceRain: 90,
//                lastUpdate: "5:00")
//    }
//}
//#endif

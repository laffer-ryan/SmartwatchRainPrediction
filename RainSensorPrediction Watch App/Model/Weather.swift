//
//  Attributes.swift
//  SmartRain Watch App
//
//  Created by Ryan Lafferty on 2/10/23.
//

import Foundation

struct Weather: Identifiable, Codable {
    var id = UUID()
    var barometerPressure: Double = 20.0
    var temperature: Double = 20.0
    var lastUpdate =  Date()
}



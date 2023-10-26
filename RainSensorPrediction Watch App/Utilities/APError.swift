//
//  APError.swift
//  RainSensorPrediction Watch App
//
//  Created by Ryan Lafferty on 26/10/23.
//

import Foundation

enum APError: Error {
    case invalidAuthorization
    case invalidPressureResponse
    case unavailableAltimeterData
    case invalidAltimeterData
    case invalidResponse
}

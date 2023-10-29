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
    case invalidCoreMotionResponse
    case invalidCoreMotionData
    case invalidResponse
    case predictionError
    case invalidWeatherData
}

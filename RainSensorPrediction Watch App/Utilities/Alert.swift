//
//  Alert.swift
//  AppetizerApp
//
//  Created by Ryan Lafferty on 8/10/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //Mark: Network Alert
    static let invalidAuthorization = AlertItem(title: Text("Authorization Error"),
                                              message: Text("Authorization is needed to access sensor data on Smart Watch"),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidPressureResponse = AlertItem(title: Text("Pressure Error"),
                                              message: Text("The ambient pressure data is currently unavailable"),
                                              dismissButton: .default(Text("OK")))
    
    static let unavailableAltimeterData = AlertItem(title: Text("Pressure Error"),
                                              message: Text("The altimeter data is currently unavailable"),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidAltimeterData = AlertItem(title: Text("Pressure Error"),
                                              message: Text("The altimeter data is invalid"),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid response from server. Please try again later."),
                                              dismissButton: .default(Text("OK")))

}


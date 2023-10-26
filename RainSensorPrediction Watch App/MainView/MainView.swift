//
//  MainView.swift
//  SmartRain Watch App
//
//  Created by Ryan Lafferty on 30/09/23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewViewModel()
    var body: some View {
        VStack {
            Text("SmartRain")
                .fontWeight(.bold)
                .font(.title2)
            
            Spacer()
            
            HStack {
                VStack {
                    Text("Temperature: \(viewModel.weather.temperature)°C")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 5)
                    Text("+/- Pressure: \(viewModel.weather.barometerPressure)")
                        .fixedSize(horizontal: false, vertical:true)
                }
                .font(.system(size: 13))
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                Text("Percent Rain: \(viewModel.predictedTemperature)%")
                    .font(.system(size: 20))
                    .padding(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Button{
            } label: {
                            Text("Refresh")
                        }
                        .font(.title3)
                        .padding(.top, 10)
                        .cornerRadius(10)
                        .shadow(radius: 4)
            VStack{
                Text("Last Updated \(viewModel.weather.lastUpdate)")
                    .font(.system(size: 13))
            }
        }
    }
}

#Preview {
    MainView()
}


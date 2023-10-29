//
//  MainView.swift
//  SmartRain Watch App
//
//  Created by Ryan Lafferty on 30/09/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    let formatter = DateFormatter()

    var timeString: String {
      formatter.dateFormat = "dd/MM HH:mm"
      return formatter.string(from: viewModel.weather.lastUpdate)
    }
    
    var body: some View {
        VStack {
            Text("SmartRain")
                .fontWeight(.bold)
                .font(.title2)
                .padding(.trailing, 20)
            
            Spacer()
            
            HStack {
                VStack {
                    Text("Temperature: \(Int(viewModel.weather.temperature))°C")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 5)
                    Text("+/- Pressure: \(Int(viewModel.weather.barometerPressure)) hPa")
                        .fixedSize(horizontal: false, vertical:true)
                }
                .font(.system(size: 13))
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                Text("Percent Rain: \(Int(viewModel.prediction * 100))%")
                    .font(.system(size: 20))
                    .padding(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Button{
                viewModel.getWeather()
                viewModel.fetchPastWeather()
                viewModel.calculateRainPercentage()
                
            } label: {
                Text("Refresh")
            }
            .font(.title3)
            .padding(.top, 10)
            .cornerRadius(10)
            .shadow(radius: 4)
            VStack{
                Text("Updated \(timeString)")
                    .font(.system(size: 13))
            }
        }
        .onAppear {
            viewModel.getWeather()
            viewModel.fetchPastWeather()
            viewModel.calculateRainPercentage()
        }
    }
}

#Preview {
    MainView()
}


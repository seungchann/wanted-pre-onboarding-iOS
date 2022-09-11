//
//  Weather.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/06.
//

struct WeatherResponse: Decodable {
    let weather: [WeatherSummary]
    let main: Weather
    let wind: Wind
    let id: Int
    var name: String
}

struct Weather: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
}

struct WeatherSummary: Decodable {
    let icon: String
    let description: String
}

struct Wind: Decodable {
    let speed: Double
}

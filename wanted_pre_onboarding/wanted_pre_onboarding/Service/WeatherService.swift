//
//  WeatherService.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/06.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
    case iconLoadingError
}

class WeatherService {
    static var shared: WeatherService = WeatherService()
    
    private let APIKey = "086e3b00efd5c9d4dd31883ac4ac3772"
    
    func getWeather(cityID: Int, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityID)&units=metric&appid=\(APIKey)")
        
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

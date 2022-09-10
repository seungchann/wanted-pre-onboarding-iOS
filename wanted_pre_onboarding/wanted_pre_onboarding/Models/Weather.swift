//
//  Weather.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/06.
//

//{"coord":{"lon":129.3167,"lat":35.5372},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":294.17,"feels_like":294.36,"temp_min":294.17,"temp_max":294.17,"pressure":996,"humidity":78,"sea_level":996,"grnd_level":995},"visibility":10000,"wind":{"speed":9.07,"deg":295,"gust":17.86},"clouds":{"all":100},"dt":1662425845,"sys":{"country":"KR","sunrise":1662411505,"sunset":1662457474},"timezone":32400,"id":1833747,"name":"Ulsan","cod":200}


struct WeatherResponseList: Decodable {
    let list: [WeatherResponse]
}

struct WeatherResponse: Decodable {
    let weather: [WeatherSummary]
    let main: Weather
    let wind: Wind
    let id: Int
    let name: String
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

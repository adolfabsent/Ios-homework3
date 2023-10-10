//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Максим Зиновьев on 10.10.2023.
//

import Foundation

enum AppConfiguration {
    case peopleURL(String)
    case starshipsURL(String)
    case planetsURL(String)

    static func getArrayURL() -> [AppConfiguration] {
        return [AppConfiguration.peopleURL("https://swapi.dev/api/people/8"),
                AppConfiguration.starshipsURL("https://swapi.dev/api/starships/3"),
                AppConfiguration.planetsURL("https://swapi.dev/api/planets/5")]
    }
}

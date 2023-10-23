//
//  PlanetModel.swift
//  Navigation
//
//  Created by Максим Зиновьев on 23.10.2023.
//

import UIKit

struct PlanetModel: Decodable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

func getRotationPeriod(completion: ((_ planetModel: PlanetModel?)->Void)?) {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: URL(string: "https://swapi.dev/api/planets/1")!) { data, responce, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (responce as! HTTPURLResponse).statusCode != 200 {
            print("Статус code != 200, statusCode = \((responce as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }

        guard let data else {
            print("data = nil")
            completion?(nil)
            return
        }
        do {

            let planetModel = try JSONDecoder().decode(PlanetModel.self, from: data)
            completion?(planetModel)
            return

        } catch {
            print(error)
        }
        completion?(nil)
    }
    task.resume()
}

struct Residents: Decodable {
    var name: String

    static func downloadPlanetResidentsData(url: String, completion: ((_ answerText: String) -> Void )?) {

        let session = URLSession(configuration: .default)
        let url = URL(string: url)
        let task = session.dataTask(with: url!) { data, response, error in
            if let error {
                print(error)
                return
            }

            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if statusCode != 200 {
                print("statusCode != 200")
                return
            }

            guard let data else {
                print("data = \(String(describing: data))")
                return
            }

            do {
                let answer = try JSONDecoder().decode(Residents.self, from: data)
                completion?(answer.name)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

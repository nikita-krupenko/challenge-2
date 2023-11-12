//
//  JSONManager.swift
//  TestJson
//
//  Created by nikita on 09.11.2023.
//

import Foundation

struct RootData: Codable {
    let artists: [Artist]
}

struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
}

struct Work: Codable,Equatable {
   
    let title: String
    let image: String
    let info: String
}

func decodeArtistData() -> [Artist] {
    if let path = Bundle.main.path(forResource: "example", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let rootData = try decoder.decode(RootData.self, from: data)
            return rootData.artists
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    return []
}

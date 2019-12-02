//
//  Endpoint.swift
//  StarWarsProject
//
//  Created by Juan Torres on 7/17/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItem: String { get }
    
}
//using these enums as a path. 
enum StarWars {
    case Character
    case Vehicle
    case Starship
}


extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = queryItem
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

struct StarWarsPage: Endpoint
{
    var starType : StarWars
    var page : Int
    
    var base = "https://swapi.co"
    
    var path: String{
        switch starType {
        case .Character: return "/api/people/"
        case .Starship: return "/api/starships/"
        case .Vehicle: return "/api/vehicles/"
        }
    }
    
    var queryItem: String {
        return "page=\(page)"
    }
    
    
    init (starType: StarWars)
    {
        self.starType = starType
        self.base = "https://swapi.co"
        self.page = 1
        
    }
    
    func getpath()-> String
    {
        switch starType.self
        {
        case .Character: return "/api/people/"
        case .Starship: return "/api/starships/"
        case .Vehicle: return "/api/vehicles/"
        }
    }
    
    }



extension StarWars: Endpoint {
    var base: String {
        return "https://swapi.co"
    }
    
    var path: String {
        switch self {
        case .Character: return "/api/people/"
        case .Starship: return "/api/starships/"
        case .Vehicle: return "/api/vehicles/"
        }
    }
    
    var queryItem: String {
        return "page=1"
    }
    
    
}





























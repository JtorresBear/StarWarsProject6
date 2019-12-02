//
//  StarWarsAPIClient.swift
//  StarWarsProject
//
//  Created by Juan Torres on 11/23/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation


class StarWarsAPIClient {
    let downloader = JSONDownloader()
    
    
    func retriveCharacters(withPath character: StarWarsPage, completion: @escaping ([Character], StarWarsError?) -> Void){
        var endpoint = character
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            var characters = results.flatMap { Character(json: $0) }
            var count = 0
            while(count < characters.count - 1){
                characters[count].getName(ofHome: characters[count].home)
                count += 1
            }
            
            
            completion(characters, nil)
        }
        
    }
    
    func retrieveStarships(withPath starship: StarWarsPage, completion: @escaping ([StarShip], StarWarsError?) -> Void){
        
        var endpoint = starship
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let starships = results.flatMap { StarShip(json: $0) }
            
            completion(starships, nil)
        }
        
    }
    
    func retrieveVehicles(withPath vehicle: StarWarsPage, completion: @escaping ([Vehicle], StarWarsError?)-> Void)
    {
        var endpoint = vehicle
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let vehicle = results.flatMap { Vehicle(json: $0) }
            
            completion(vehicle, nil)
        }
    }
    
    
    
    typealias Results = [[String: Any]]
    typealias planetResults = [String: Any]
    
    private func performRequest(with endpoint: StarWarsPage, completion: @escaping (Results?, StarWarsError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let results = json["results"] as? [[String: Any]] else {
                    completion(nil, .jsonParsingFailure(message: "JSON data does not contain results"))
                    
                    return
                }
                
                completion(results, nil)
            }
        }
        
        task.resume()
        
    }
    
    func performRequest(with URLString: String, completion: @escaping (String, StarWarsError?) -> Void){
        let url = URL.init(string: URLString)!
       // print(url)
        let urlRequest = URLRequest(url: url)
        //print(urlRequest)
        let task = downloader.jsonTask(with: urlRequest){ json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion("", error)
                   // print("didn't work")
                    return
                }
//                print(json["name"])
                //print(json)
                guard let results = json["name"] as? String else {
                    completion("", .jsonParsingFailure(message: "no Planet data for you"))
                    return
                }
                completion(results, nil)
            }
            
        }
        
        task.resume()
        
        
    }
    
    
}















































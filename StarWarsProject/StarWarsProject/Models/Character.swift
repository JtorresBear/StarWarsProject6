//
//  Characters.swift
//  StarWarsProject
//
//  Created by Juan Torres on 5/11/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation

class StarWarsList {}

class Character: StarWarsList
{
    var client = StarWarsAPIClient()
    
    var name: String
    var birthYear: String
    var home: String
    var height: String
    var eyeColor: String
    var hairColor: String
    var homeName: String = ""
    var doubleHeight: Double? = nil
    
    init(name: String, birthYear: String, home: String, height: String, eyeColor: String, hairColor: String)
    {
        self.name = name
        self.birthYear = birthYear
        self.home = home
        self.height = height
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        
        if(height.isDouble())
        {
            self.doubleHeight = height.toDouble()
        }
        
    }
    
    func getName(ofHome home: String)
    {
        client.performRequest(with: home) { (home, error) in
            
            self.homeName = home
            print("tried")
            
        }
    }
    
    
}

extension Character {
    convenience init?(json: [String: Any]){
        struct Key {
            static let characterName = "name"
            static let characterBirthYear = "birth_year"
            static let characterHome = "homeworld"
            static let characterheight = "height"
            static let characterEyeColor = "eye_color"
            static let characterHairColor = "hair_color"
        }
        
        guard let name = json[Key.characterName] as? String,
        let year = json[Key.characterBirthYear] as? String,
        let home = json[Key.characterHome] as? String,
        let height = json[Key.characterheight] as? String,
        let eyeColor = json[Key.characterEyeColor] as? String,
            let hairColor = json[Key.characterHairColor] as? String else {
                return nil
        }
        
        
        self.init(name: name, birthYear: year, home: home, height: height, eyeColor: eyeColor, hairColor: hairColor)
        
    }
}


extension Character: Comparable
{
    static func < (lhs: Character, rhs: Character) -> Bool {
        if(lhs.doubleHeight == nil){
            return false
        } else if(rhs.doubleHeight ==  nil){
            return false
        }
        
        
        return lhs.doubleHeight! < rhs.doubleHeight!
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.height == rhs.height
    }
    
    static func > (lhs: Character, rhs: Character) -> Bool {
        if(lhs.doubleHeight == nil){
            return false
        } else if(rhs.doubleHeight ==  nil){
            return false
        }
        
        return lhs.doubleHeight! > rhs.doubleHeight!
    }
    
    
}































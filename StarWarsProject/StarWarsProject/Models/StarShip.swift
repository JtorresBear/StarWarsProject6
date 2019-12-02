//
//  StarShip.swift
//  StarWarsProject
//
//  Created by Juan Torres on 5/18/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation

class StarShip: StarWarsList
{
    var name: String
    var make: String
    var cost: String
    var sClass: String
    var crew: String
    var length: String
    var doubleCost: Double? = nil
    var doubleLength: Double? = nil
    
    
    init(name: String, make: String, cost: String, sClass: String, crew: String, length: String)
    {
        self.name = name
        self.make = make
        self.cost = cost
        self.sClass = sClass
        self.crew = crew
        self.length = length
        
        if(cost.isDouble()){
            doubleCost = cost.toDouble()
        }
        if(length.isDouble()){
            doubleLength = length.toDouble()
        }
        
        
    }
}

extension StarShip {
    convenience init?(json:[String: Any]){
        
        struct Key{
            static let name = "name"
            static let make = "manufacturer"
            static let cost = "cost_in_credits"
            static let sClass = "starship_class"
            static let crew = "crew"
            static let length = "length"
        }
        
        guard let name = json[Key.name] as? String,
        let make = json[Key.make] as? String,
        let cost = json[Key.cost] as? String,
        let sClass = json[Key.sClass] as? String,
        let crew = json[Key.crew] as? String,
        let length = json[Key.length] as? String
            else {
                return nil
        }
        
        self.init(name: name, make: make, cost: cost, sClass: sClass, crew: crew, length: length)
        
    }
}


extension StarShip: Comparable {
    
    
    
    static func < (lhs: StarShip, rhs: StarShip) -> Bool {
        
        if(lhs.doubleLength == nil){
            return false
        }else if (rhs.doubleLength == nil ){
            return false
        }
        
        
        return lhs.doubleLength! < rhs.doubleLength!
    }
    
    static func == (lhs: StarShip, rhs: StarShip) -> Bool {
        return lhs.length == rhs.length
    }
    
    static func > (lhs: StarShip, rhs: StarShip) -> Bool {
        if(lhs.doubleLength == nil){
            return false
        }else if (rhs.doubleLength == nil ){
            return false
        }
        
        
        return lhs.doubleLength! > rhs.doubleLength!
    }
    
}





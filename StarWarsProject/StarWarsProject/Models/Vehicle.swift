//
//  Vehicles.swift
//  StarWarsProject
//
//  Created by Juan Torres on 5/11/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation

class Vehicle: StarWarsList {
    var name: String
    var make: String
    var cost: String
    var length: String
    var vehicleClass: String
    var crew: String
    var doubleLength: Double? = nil
    var doubleCost: Double? = nil
    
    init(name: String, make: String, cost: String, length: String, vehicleClass: String, crew: String){
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
        
        if(length.isDouble())
        {
            doubleLength = length.toDouble()
        }
        if(cost.isDouble()){
            doubleCost = cost.toDouble()
        }
        
    }
}

extension Vehicle {
    convenience init?(json: [String: Any])
    {
        struct Key {
            static let name = "name"
            static let make = "manufacturer"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let vClass = "vehicle_class"
            static let crew = "crew"
        }
        
        guard let name = json[Key.name] as? String,
        let make = json[Key.make] as? String,
        let cost = json[Key.cost] as? String,
        let length = json[Key.length] as? String,
        let vClass = json[Key.vClass] as? String,
        let crew = json[Key.crew] as? String
            else {
                return nil
        }
        
        self.init(name: name, make: make, cost: cost, length: length, vehicleClass:vClass, crew: crew)
        
    }
}




extension Vehicle: Comparable {
    static func < (lhs: Vehicle, rhs: Vehicle) -> Bool {
        if(lhs.doubleLength == nil){
            return false
        }else if(rhs.doubleLength == nil ){
            return false
        }
        
        
        
        return lhs.doubleLength! < rhs.doubleLength!
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.length == rhs.length
    }
    
    static func > (lhs: Vehicle, rhs: Vehicle) -> Bool {
        if(lhs.doubleLength == nil){
            return false
        }else if(rhs.doubleLength == nil ){
            return false
        }
        return lhs.doubleLength! > rhs.doubleLength!
    }
    
    
}













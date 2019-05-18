//
//  StarShip.swift
//  StarWarsProject
//
//  Created by Juan Torres on 5/18/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation

class StarShip
{
    var name: String
    var make: String
    var cost: Int
    var sClass: String
    var crew: Int
    
    init(name: String, make: String, cost: Int, sClass: String, crew: Int)
    {
        self.name = name
        self.make = make
        self.cost = cost
        self.sClass = sClass
        self.crew = crew
    }
}





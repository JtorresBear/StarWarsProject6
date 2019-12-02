//
//  HelperMethods.swift
//  StarWarsProject
//
//  Created by Juan Torres on 9/8/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import Foundation

//gets the biggest
func getBiggest <T:Comparable> (array: [T]) -> T {
    var temp = array[0]
    var count = 0
    while (count < array.count){
        if temp < array[count] {
            temp = array[count]
            
        }
        count = count + 1
    }
    
    
    return temp
}


func getSmallest <T:Comparable> (array: [T]) -> T {
    
    var temp = array[0]
    var count = 0
    while (count < array.count){
        if temp > array[count] {
            temp = array[count]
            
        }
        count = count + 1
    }
    return temp
}


extension Double {
    
    func toUSD()->String{
        let temp = self * 4.074
        
        return "$\(temp)"
    }
    func toStringTwoDecimalPlaces() -> String {
        return String(format: "%.2f",self)
    }
    
    func toStringCredits() -> String {
        return String(format: "%.0f",self)
    }
    
    func toStringInFeetFromCentimeters()->String
    {
        let temp = self / 2.54
        let feet = Int(temp) / 12
        let inches = Int(temp) % 12
        return "\(feet)'\(inches) Ft"
    }
    
    func toStringInFeetFromMeters()-> String
    {
        let temp = self * 39.37
        let feet = Int(temp) / 12
        let inches = Int(temp) % 12
        return "\(feet)'\(inches) Ft"
    }
    
    func toStringInMetersFromCentimeters()-> String {
        let temp = self/100
        
        return "\(temp)M"
    }
    
    func toStringInMeters()-> String {
        return "\(self)M"
    }
}

extension String {
    func toDouble()-> Double
    {
        return Double(self)!
    }
    
    func isDouble()->Bool{
        if let doubleValue = Double(self) {
            return true
        }
        
        return false
    }
}

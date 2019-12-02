//
//  VehiclesViewController.swift
//  StarWarsProject
//
//  Created by Juan Torres on 6/10/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var usDollarButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var usUnitsButton: UIButton!
    @IBOutlet weak var metricUnitsButton: UIButton!
    
    var vehicles = [Vehicle]()
    
    var selectedVehicle = 0
    var USD = false
    var englishLength = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels(selectedVehicle)
        picker.delegate = self
        picker.dataSource = self
        creditsButton.backgroundColor = .black
        metricUnitsButton.backgroundColor = .black

        self.navigationItem.title = "Vehicles"
    }
    
    func updateLabels(_ forVehicles: Int)
    {
        self.nameLabel.text = vehicles[forVehicles].name
        self.makeLabel.text = vehicles[forVehicles].make
        self.classLabel.text = vehicles[forVehicles].vehicleClass
        self.crewLabel.text = vehicles[forVehicles].crew.description
        self.smallestLabel.text = getSmallest(array: vehicles).name
        self.largestLabel.text = getBiggest(array: vehicles).name
        self.costLabel.text = vehicles[forVehicles].cost
        self.lengthLabel.text = vehicles[forVehicles].length
        changeLengthLabel()
        changeCostLabel()
    }
    
    
    
    
    
    func changeCostLabel()
    {
        if(USD)
        {
            if(vehicles[selectedVehicle].doubleCost == nil )
            {
                self.costLabel.text = vehicles[selectedVehicle].cost
            } else
            {
                self.costLabel.text = vehicles[selectedVehicle].doubleCost!.toUSD()
            }
        }
        if(!USD)
        {
            if(vehicles[selectedVehicle].doubleCost == nil)
            {
                self.costLabel.text = vehicles[selectedVehicle].cost
            } else
            {
                self.costLabel.text = vehicles[selectedVehicle].doubleCost!.description
            }
        }
        
    }
    
    func changeLengthLabel()
    {
        if(englishLength)
        {
            if(vehicles[selectedVehicle].doubleLength == nil )
            {
                self.lengthLabel.text = vehicles[selectedVehicle].length
            } else
            {
                self.lengthLabel.text = vehicles[selectedVehicle].doubleLength!.toStringInFeetFromMeters()
            }
        }
        if(!englishLength)
        {
            if(vehicles[selectedVehicle].doubleLength == nil)
            {
                self.lengthLabel.text = vehicles[selectedVehicle].length
            } else
            {
                self.lengthLabel.text = vehicles[selectedVehicle].doubleLength!.toStringInMeters()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func costInDollars(_ sender: Any) {
        USD = true
        updateLabels(selectedVehicle)
        usDollarButton.backgroundColor = .black
        creditsButton.backgroundColor = .clear
    }
    
    @IBAction func costInCredits(_ sender: Any) {
        USD = false
        updateLabels(selectedVehicle)
        creditsButton.backgroundColor = .black
        usDollarButton.backgroundColor = .clear
    }
    
    
    @IBAction func lengthInEnglish(_ sender: Any) {
        englishLength = true
        updateLabels(selectedVehicle)
        usUnitsButton.backgroundColor = .black
        metricUnitsButton.backgroundColor = .clear
    }
    
    
    @IBAction func lengthInMetric(_ sender: Any) {
        englishLength = false
        updateLabels(selectedVehicle)
        metricUnitsButton.backgroundColor = .black
        usUnitsButton.backgroundColor = .clear
    }
    

}

//1 credit = $4.075

extension VehiclesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return vehicles[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabels(row)
        selectedVehicle = row
        changeCostLabel()
        changeLengthLabel()
    }
}

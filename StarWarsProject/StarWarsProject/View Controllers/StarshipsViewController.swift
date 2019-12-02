//
//  StarshipsViewController.swift
//  StarWarsProject
//
//  Created by Juan Torres on 6/10/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import UIKit

class StarshipsViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var usCurrencyButton: UIButton!
    @IBOutlet weak var creditsCurrencyButton: UIButton!
    @IBOutlet weak var usUnitsButton: UIButton!
    @IBOutlet weak var metricUnitsButon: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var starShips = [StarShip]()
    var USD = false
    var englishLength = false
    var selectedStarShip = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLables(selectedStarShip)
        picker.dataSource = self
        picker.delegate = self
        metricUnitsButon.backgroundColor = .black
        creditsCurrencyButton.backgroundColor = .black
        self.navigationItem.title = "Star Ships"
        
        
    }
    
    func updateLables(_ forStarShips: Int){
        self.nameLabel.text = starShips[forStarShips].name
        
        self.makeLabel.text = starShips[forStarShips].make
        self.classLabel.text = starShips[forStarShips].sClass
        self.crewLabel.text = starShips[forStarShips].crew
        
        self.smallestLabel.text = getSmallest(array: starShips).name
        self.largestLabel.text =  getBiggest(array: starShips).name
       
        //self.costLabel.text = starShips[forStarShips].cost
        changeCostLabel()
        changeLengthLabel()
        //self.lengthLabel.text = starShips[forStarShips].length
    }
    
    
    @IBAction func changeToDollars(_ sender: Any) {
        USD = true
        updateLables(selectedStarShip)
        usCurrencyButton.backgroundColor = .black
        creditsCurrencyButton.backgroundColor = .clear
    }
    

    @IBAction func changeToCredits(_ sender: Any) {
        USD = false
        updateLables(selectedStarShip)
        creditsCurrencyButton.backgroundColor = .black
        usCurrencyButton.backgroundColor = .clear
    }
    
    
    @IBAction func changeToEnglish(_ sender: Any) {
        englishLength = true
        updateLables(selectedStarShip)
        usUnitsButton.backgroundColor = .black
        metricUnitsButon.backgroundColor = .clear
        
    }
    
    @IBAction func changeToMetric(_ sender: Any) {
        englishLength = false
        updateLables(selectedStarShip)
        usUnitsButton.backgroundColor = .clear
        metricUnitsButon.backgroundColor = .black
    }
    
    func changeCostLabel()
    {
        if(USD)
        {
            if(starShips[selectedStarShip].doubleCost == nil )
            {
                self.costLabel.text = starShips[selectedStarShip].cost
            } else
            {
                self.costLabel.text = starShips[selectedStarShip].doubleCost!.toUSD()
            }
        }
        if(!USD)
        {
            if(starShips[selectedStarShip].doubleCost == nil)
            {
                self.costLabel.text = starShips[selectedStarShip].cost
            } else
            {
                self.costLabel.text = starShips[selectedStarShip].doubleCost!.description
            }
        }
    }
    
    func changeLengthLabel()
    {
        if(englishLength)
        {
            if(starShips[selectedStarShip].doubleLength == nil )
            {
                self.lengthLabel.text = starShips[selectedStarShip].length
            } else
            {
                self.lengthLabel.text = starShips[selectedStarShip].doubleLength!.toStringInFeetFromMeters()
            }
        }
        if(!englishLength)
        {
            if(starShips[selectedStarShip].doubleLength == nil)
            {
                self.lengthLabel.text = starShips[selectedStarShip].length
            } else
            {
                self.lengthLabel.text = starShips[selectedStarShip].doubleLength!.toStringInMeters()
            }
        }
    }
    
    
    

    

}


extension StarshipsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return starShips.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return starShips[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLables(row)
        selectedStarShip = row
        changeLengthLabel()
        changeCostLabel()
    }
}

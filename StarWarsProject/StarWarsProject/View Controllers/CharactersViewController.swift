//
//  CharactersViewController.swift
//  StarWarsProject
//
//  Created by Juan Torres on 6/10/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

    // make an extension to make a delagate to pickerView and Picker Delagate and all that stuff from that video . and see if it works... 
    let client = StarWarsAPIClient()
    
    
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyesLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var smallestCharacterLabel: UILabel!
    @IBOutlet weak var largestCharacterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usMeasureButton: UIButton!
    @IBOutlet weak var metricMeasureButton: UIButton!
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    var characters = [Character]()
    var selectedCharacter = 0
    var isMetric = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        metricMeasureButton.backgroundColor = .black
        updateLabels(selectedCharacter)
        self.navigationItem.title = "Characters"
        // Do any additional setup after loading the view.
    }
    
    func updateLabels(_ forCharacters: Int)
    {
        
        self.smallestCharacterLabel.text = getSmallest(array: characters).name
        self.largestCharacterLabel.text = getBiggest(array: characters).name
        self.homeLabel.text = characters[forCharacters].homeName
        self.eyesLabel.text = characters[forCharacters].eyeColor
        self.hairLabel.text = characters[forCharacters].hairColor
        self.dobLabel.text = characters[forCharacters].birthYear
        self.nameLabel.text = characters[forCharacters].name
        changeHeightLabel()
        
    }
    
    
    @IBAction func toEnglishHeight(_ sender: Any) {
        isMetric = false
        updateLabels(selectedCharacter)
        usMeasureButton.backgroundColor = .black
        metricMeasureButton.backgroundColor = .clear
    }
    
    @IBAction func toMetricHeight(_ sender: Any) {
        isMetric = true
        updateLabels(selectedCharacter)
        metricMeasureButton.backgroundColor = .black
        usMeasureButton.backgroundColor = .clear
        
    }
    
    func changeHeightLabel(){
        if(isMetric)
        {
            if(characters[selectedCharacter].doubleHeight == nil)
            {
                self.heightLabel.text = characters[selectedCharacter].height
            } else
            {
                self.heightLabel.text = (characters[selectedCharacter].doubleHeight!.toStringInMetersFromCentimeters())
            }
            
        }
        
        if(!isMetric)
        {
            if(characters[selectedCharacter].doubleHeight == nil)
            {
                self.heightLabel.text = characters[selectedCharacter].height
            } else
            {
                self.heightLabel.text = (characters[selectedCharacter].doubleHeight!.toStringInFeetFromCentimeters())
            }
        }
    }
    
    
    
    
    
    
}





extension CharactersViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characters[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabels(row)
        selectedCharacter = row
        changeHeightLabel()
        
    }
}

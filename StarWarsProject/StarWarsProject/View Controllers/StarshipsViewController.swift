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
    @IBOutlet weak var exchangeButton: UIButton!
    @IBOutlet weak var exchangeRateTextField: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    let client = StarWarsAPIClient()
    var starShips = [StarShip]()
    var USD = false
    var englishLength = false
    var selectedStarShip = 0
    let helper = helperMethods()
    var USDollar: Double = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveStarShips()
        picker.dataSource = self
        picker.delegate = self
        metricUnitsButon.backgroundColor = .black
        creditsCurrencyButton.backgroundColor = .black
        exchangeSetup()
        self.navigationItem.title = "Star Ships"
        
        
    }
    
    func updateLables(_ forStarShips: Int){
        self.nameLabel.text = starShips[forStarShips].name
        
        self.makeLabel.text = starShips[forStarShips].make
        self.classLabel.text = starShips[forStarShips].sClass
        self.crewLabel.text = starShips[forStarShips].crew
        changeCostLabel()
        changeLengthLabel()
    }
    func exchangeSetup(){
        
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30 )))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace,donebutton], animated: false)
        toolbar.sizeToFit()
        
        exchangeRateTextField.keyboardType = .numberPad
        exchangeRateTextField.text = "1"
        exchangeRateTextField.delegate = self
        exchangeRateTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction()
    {
        self.view.endEditing(true)
    }
    
    @IBAction func checkExchangeRates(_ sender: Any) {
        let exchangeRateScreen = ExchangeRateViewController()
        navigationController?.pushViewController(exchangeRateScreen, animated: true)
    }
    
    @IBAction func changeToDollars(_ sender: Any) {
        USD = true
        checkTextField()
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
                self.costLabel.text = (USDollar * starShips[selectedStarShip].cost.toDouble()).description
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
    
    func checkTextField(){
        
        var creditsDigit: Double = 0
        
        guard let credits = exchangeRateTextField.text else {
            return
        }
        
        if credits == "" {
            createAlert(for: .noInput)
            return
        } else if !credits.isDouble() {
            createAlert(for: .notNumber)
            return
        } else if credits.isDouble() {
            creditsDigit = credits.toDouble()
        }
        
        if creditsDigit < 0 {
            createAlert(for: .lessThanZero)
            return
        }
        
        USDollar = creditsDigit
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
    
    
    func retrieveStarShips(){
        var dataStarships = StarWarsPage(starType: .Starship)
        while (dataStarships.page < 5){
            
            client.retrieveStarships(withPath: dataStarships ) { [weak self] starships, error in
                self?.updateStarShips(with: starships)
            }
            dataStarships.page += 1
            
        }
        
    }
    
    func updateStarShips(with starships: [StarShip]){
        var count = 0
        while(count < starships.count){
            starShips.append(starships[count])
            count += 1
        }
        updateLables(0)
        picker.reloadAllComponents()
        
    }
    
    

    

}


extension StarshipsViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
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
        
        self.nameLabel.text = starShips[row].name
        
        self.makeLabel.text = starShips[row].make
        self.classLabel.text = starShips[row].sClass
        self.crewLabel.text = starShips[row].crew
        
        self.smallestLabel.text = helper.getSmallest(array: starShips).name
        self.largestLabel.text =  helper.getBiggest(array: starShips).name
        checkTextField()
        changeCostLabel()
        changeLengthLabel()
    }
    
    func createAlert(for error: ExchangeError)
    {
        var message = ""
        
        var action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.usCurrencyButton.backgroundColor = .black
            self.creditsCurrencyButton.backgroundColor = .clear
            self.USD = false
            self.exchangeRateTextField.text = "1"
        }
        
        switch error{
        case .noInput: message = "There's no Input"
        case .notGalacticCredit: message = "Use a galactic Credit to see US Dollar"
        case .notNumber: message = "Please no letters or symbols"
        case .lessThanZero: message = "Has to be greater than 0"
        case .equalToZero: message = "Has to be greater than 0"
        case .lessThanOne: message = "Exchange Rate less than 1"
        }
        
        
        let alert = UIAlertController(title: "Something happened", message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    enum ExchangeError{
        case noInput
        case notGalacticCredit
        case notNumber
        case lessThanZero
        case equalToZero
        case lessThanOne
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkTextField()
        updateLables(selectedStarShip)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTextField()
        updateLables(selectedStarShip)
    }
}

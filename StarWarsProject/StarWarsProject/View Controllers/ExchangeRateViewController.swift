//
//  ExchangeRateViewController.swift
//  StarWarsProject
//
//  Created by Juan Torres on 12/12/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {

    
    let currencyTextField = UITextField()
    let exchangeLable = UILabel()
    let titleLabel = UILabel()
    let exchangeButton = UIButton()
    let labelSwitch = UISwitch()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setUpLabel()
        setUpButton()
        setUpLabel2()
        setUpSwitch()
        view.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
    }
    
    func setUpButton(){
        exchangeButton.setTitle("Exchange Rate", for: .normal)
        exchangeButton.backgroundColor = .lightGray
        exchangeButton.setTitleColor(.black, for: .normal)
        
        exchangeButton.addTarget(self, action: #selector(showExchange), for: .touchUpInside)
        
        view.addSubview(exchangeButton)
        setButtonConstraints()
    }
    
    @objc func showExchange()
    {
        var creditsD: Double = 0
        guard let credits = currencyTextField.text else {
            return
        }
        if credits == ""
        {
            createAlert(for: .noInput)
            return
        }else if !credits.isDouble(){
            createAlert(for: .notNumber)
            return
        } else if credits.isDouble(){
            creditsD = credits.toDouble()
        }
        
        if (creditsD < 0)
        {
            createAlert(for: .lessThanZero)
            return
        }
        
        if (creditsD == 0 ){
            createAlert(for: .equalToZero)
            return
        }
        
        if labelSwitch.isOn == true{
            titleLabel.text = "USD to Credits"
            exchangeLable.text = creditsD.usdTOCredits()
        } else {
            titleLabel.text = "Credits to USD"
            exchangeLable.text = creditsD.toUSD()
        }
    }
    
    
    func setButtonConstraints(){
        
        exchangeButton.translatesAutoresizingMaskIntoConstraints = false
        exchangeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exchangeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        exchangeButton.heightAnchor.constraint(equalToConstant: 50)
    }
    
    
    func setSwitchConstraints(){
        labelSwitch.translatesAutoresizingMaskIntoConstraints = false
        labelSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100).isActive = true
        labelSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        labelSwitch.heightAnchor.constraint(equalToConstant: 50)
    }
    
    
    
    func setUpLabel(){
        exchangeLable.text = "Hello"
        view.addSubview(exchangeLable)
        setLabelConstraints()
    }
    func setUpLabel2(){
        titleLabel.text = "Credits to USD"
        view.addSubview(titleLabel)
        setLabelConstraints2()
    }
    
    func setUpSwitch(){
        labelSwitch.isOn = false
        view.addSubview(labelSwitch)
        setSwitchConstraints()
        labelSwitch.addTarget(self, action: #selector(switchTriggered(sentSwitch:)), for: .valueChanged)
    }
    
    @objc func switchTriggered(sentSwitch: UISwitch) {
        if labelSwitch.isOn == true{
            titleLabel.text = "USD to Credits"
        }else {
            titleLabel.text = "Credits to USD"
        }
    }
    
    
    
    
    func setLabelConstraints()
    {
        exchangeLable.translatesAutoresizingMaskIntoConstraints = false
        exchangeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exchangeLable.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        exchangeLable.heightAnchor.constraint(equalToConstant: 50)
        
    }
    
    func setLabelConstraints2()
    {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50)
        
    }
    
    
    func setupTextField()
    {
        currencyTextField.delegate = self
        currencyTextField.backgroundColor = .white
        currencyTextField.placeholder = "numbers only!"
        currencyTextField.textAlignment = .center
        currencyTextField.font = UIFont.systemFont(ofSize: 15)
        currencyTextField.keyboardType = UIKeyboardType.numberPad
        view.addSubview(currencyTextField)
        setTextFieldConstraints()
    }
    
    func setTextFieldConstraints()
    {
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        currencyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currencyTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        currencyTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        currencyTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func createAlert(for error: ExchangeError)
    {
        var message = ""
        var action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.currencyTextField.text = ""
            
        }
        
        switch error{
        case .noInput: message = "There's no Input"
        case .notGalacticCredit: message = "Use a galactic Credit to see US Dollar"
        case .notNumber: message = "Please no letters or symbols"
        case .lessThanZero: message = "Has to be greater than 0"
        case .equalToZero: message = "Has to be greater than 0"
        }
    
        
        let alert = UIAlertController(title: "Something happened", message: message, preferredStyle: .alert)
        alert.addAction(action)
        exchangeLable.text = "I SAID HELLO"
        
        present(alert, animated: true, completion: nil)
    }
    
    
    enum ExchangeError{
        case noInput
        case notGalacticCredit
        case notNumber
        case lessThanZero
        case equalToZero
    }
    

}


extension ExchangeRateViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }
    
    
}


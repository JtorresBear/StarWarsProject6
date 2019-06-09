//
//  ViewController.swift
//  StarWarsProject
//
//  Created by Juan Torres on 5/6/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var CharactersButton: UIButton!
    @IBOutlet weak var VehiclesButton: UIButton!
    @IBOutlet weak var StarShipsButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func justPrintForNow(_ sender: UIButton) {
        switch sender {
        case CharactersButton: print("characters")
        case VehiclesButton: print("vehicles")
        case StarShipsButton: print("starships")
        default: print("stuff")}
        
        
    }
    
    
    
    

}


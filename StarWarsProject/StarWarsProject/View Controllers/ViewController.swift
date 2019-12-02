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
    
    var client = StarWarsAPIClient()
    var theseCharacters = [Character]()
    var theseVehicles = [Vehicle]()
    var theseStarships = [StarShip]()

    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveCharacters()
        retrieveVehicles()
        retrieveStarShips()
    }

    
    func retrieveCharacters()
    {
        var dataCharacters = StarWarsPage(starType: .Character)
        while (dataCharacters.page < 10)
        {
            client.retriveCharacters(withPath: dataCharacters ) { [weak self] characters, error in
                self?.updateCharacters( with: characters)
            }
            dataCharacters.page += 1
        }
    }
    
    
    func updateCharacters(with char : [Character])
    {
        var count = 0
        while(count < char.count)
        {
            theseCharacters.append(char[count])
            count+=1
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
            theseStarships.append(starships[count])
            count += 1
        }
    }
    
    func retrieveVehicles(){
        var dataVehicles = StarWarsPage(starType: .Vehicle)
        
        while(dataVehicles.page < 5){
            client.retrieveVehicles(withPath: dataVehicles ) { [weak self] vehicles, error in
                self?.updateVehicles(with: vehicles)
            }
            dataVehicles.page += 1
        }
    }
    func updateVehicles(with vehicles: [Vehicle]){
        var count = 0
        while(count < vehicles.count){
            theseVehicles.append(vehicles[count])
            count += 1
        }
    }
    
    
    
    
    
    
    
    @IBAction func justPrintForNow(_ sender: UIButton) {
        switch sender {
        case CharactersButton: print("characters");
        case VehiclesButton: print("vehicles")
        case StarShipsButton: print("starships")
        default: print("stuff")}

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterSegue"
        {
            let viewController = segue.destination as! CharactersViewController
            viewController.characters = theseCharacters

        }
        else
            if segue.identifier == "vehicleSegue"{
            let viewController = segue.destination as! VehiclesViewController
            viewController.vehicles = theseVehicles
        }
        else if segue.identifier == "starshipsSegue" {
            let viewController = segue.destination as! StarshipsViewController
            viewController.starShips = theseStarships
        }
    }
    
    

}



//
//  CharacterViewController.swift
//  StarWarsProject
//
//  Created by Juan Torres on 6/3/19.
//  Copyright © 2019 Juan Torres. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CharacterViewController.dismissCharacterViewController))
        // Do any additional setup after loading the view.
    }
    
    
    
    
    // dismisses the current view to 
    @objc func dismissCharacterViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

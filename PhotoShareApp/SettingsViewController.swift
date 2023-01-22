//
//  SettingsViewController.swift
//  PhotoShareApp
//
//  Created by Emre Sahin on 21.01.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    
    @IBAction func exitButton(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch{
            print("Error!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

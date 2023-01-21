//
//  SettingsViewController.swift
//  PhotoShareApp
//
//  Created by Emre Sahin on 21.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBAction func exitButton(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

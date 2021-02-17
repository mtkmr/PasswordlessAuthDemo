//
//  ViewController.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Setup.shouldOpenMailApp {
            Setup.shouldOpenMailApp = false
            if let url = URL(string: "message://") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    print("Could not open url.")
                }
            }
        }
    }


}


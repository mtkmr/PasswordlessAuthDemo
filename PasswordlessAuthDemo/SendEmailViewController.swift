//
//  SendEmailViewController.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit
import Firebase

class SendEmailViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendEmailTapped(_ sender: UIButton) {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://noPasswordAuth.com/open")
        actionCodeSettings.dynamicLinkDomain = "nopasswordauth.page.link"
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        if let email = emailTextField.text {
            Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                UserDefaults.standard.set(email, forKey: "Email")
                Setup.shouldOpenMailApp = true
                self.navigationController?.popToRootViewController(animated: true)
                print("Check your email for link")
            }
        }
        
    }
    

}

//
//  SendEmailViewController.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit
import Firebase

class SendEmailViewController: UIViewController {
    
    var hud = Hud.create()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendEmailTapped(_ sender: UIButton) {
        
        Hud.handle(hud, with: HudInfo(type: .show, text: "Working", detailText: "Sending email..."))
        
        //メールリンクの作成方法を Firebase に伝える ActionCodeSettings オブジェクトを作成
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://passwordlessauthdemo.firebaseapp.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        if let email = emailTextField.text {
            Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    Hud.handle(self.hud, with: HudInfo(type: .error, text: "Error", detailText: err.localizedDescription))
                    return
                }
                print("サインイン用のメール送信完了")
                //再認証で使用するために、emailを保存させておく
                UserDefaults.standard.set(email, forKey: "Email")
                
                Hud.handle(self.hud, with: HudInfo(type: .success, text: "Success", detailText: "Email sent!"))
                //アラート表示
                let openMailAppAction = UIAlertAction(title: "Open Mail App", style: .default, handler: { (action) in
                    Setup.shouldOpenMailApp = true
                    self.navigationController?.popToRootViewController(animated: true)
                })
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                self.showAlert(title: "メールを確認してください。", message: "メールにリンクを送信しました。リンクから認証を完了してください。", actions: [openMailAppAction, okAction])
                
                
                
               
            }
        }
        
    }
    

}

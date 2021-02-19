//
//  ViewController.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    var hud = Hud.create()
    
    @IBOutlet weak var signInSignOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //認証状態をリアルタイムに取得
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                //サインインしていないとき
                print("User is nil")
                Service.authState = .signedOut
                self.navigationItem.title = "Profile"
                self.signInSignOutButton.setTitle("Sign In", for: .normal)
            }
            if let user = user, let email = user.email {
                //ユーザーがサインインしているとき
                print("email: \(email)のユーザーがいます")
                Service.authState = .signedIn
                self.navigationItem.title = email
                self.signInSignOutButton.setTitle("Sign Out", for: .normal)
            }
            
        }
        
        if Setup.shouldOpenMailApp {
            Setup.shouldOpenMailApp = false
            if let url = URL(string: "message://") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    print("メールアプリURLが開けません。")
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    showAlert(title: "メールアプリが開けません。", message: "メールをご確認ください。", actions: [defaultAction])
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //remove authStateDidChangeListenerHandle
        guard let authStateDidChangeListenerHandle = authStateDidChangeListenerHandle else { return }
        Auth.auth().removeStateDidChangeListener(authStateDidChangeListenerHandle)
        
    }
    
    
    @IBAction func signInSignOutButtonTapped(_ sender: UIButton) {
        
        switch Service.authState {
        case .signedIn:
            signOut()
        case .signedOut:
            goToSendEmailViewController()
        }
        
    }
    
    private func signOut() {
        //サインアウト
        let detailText = "Signing out..."
        Hud.handle(hud, with: HudInfo(type: .show, text: "Working", detailText: detailText))
        
        let auth = Auth.auth()
        do {
            try auth.signOut()
            Hud.handle(hud, with: HudInfo(type: .success, text: "ログアウト成功", detailText: "ログアウトしました"))
        } catch let err {
            print(err.localizedDescription)
            Hud.handle(hud, with: HudInfo(type: .error, text: "Error", detailText: err.localizedDescription))
        }
    }
    
    private func goToSendEmailViewController() {
        let sendEmailViewController = storyboard?.instantiateViewController(identifier: "SendEmailViewController") as! SendEmailViewController
        navigationController?.pushViewController(sendEmailViewController, animated: true)
    }


}


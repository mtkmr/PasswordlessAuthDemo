//
//  SceneDelegate.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        print(userActivity.webpageURL!)
        
        guard let url = userActivity.webpageURL else { return }
        let link = url.absoluteString
        //メールのリンクから来たときのみ呼ばれる
        if Auth.auth().isSignIn(withEmailLink: link) {
            guard let email = UserDefaults.standard.value(forKey: Setup.kEmail) as? String else {
                print("Error signing in: email does not exist")
                return
            }
            //ログイン処理
            Auth.auth().signIn(withEmail: email, link: link) { (auth, err) in
                if let err = err {
                    print(err.localizedDescription)
                    print("ログイン失敗")
                    return
                }
                
                guard let auth = auth else {
                    print("Error signing in.")
                    return
                }
                
                let uid = auth.user.uid
                print("Successfully signed in user with uid: \(uid)")
                print("ログイン成功")
                UserDefaults.standard.setValue(true, forKey: "IsLogin")
            }
        }
    }
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


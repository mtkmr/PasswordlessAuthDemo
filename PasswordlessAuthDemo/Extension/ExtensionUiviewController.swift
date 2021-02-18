//
//  ExtensionUIViewController.swift
//  GurumeshiApp
//
//  Created by Masato Takamura on 2021/01/22.
//  Copyright © 2021 Masato Takamura. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach {alertController.addAction($0)}
        present(alertController, animated: true)
    }
}

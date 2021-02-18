//
//  ExtensionUIApplication.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        
        return base
    }
}

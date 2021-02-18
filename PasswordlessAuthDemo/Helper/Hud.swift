//
//  Hud.swift
//  PasswordlessAuthDemo
//
//  Created by Masato Takamura on 2021/02/18.
//

import UIKit
import JGProgressHUD

//HUDの種類
enum HudType {
    case none
    case show
    case update
    case success
    case error
}

//HUDの情報
struct HudInfo {
    let type: HudType
    let text: String
    let detailText: String
}

class Hud {
    
//    MARK: - HUDを扱う
    static func handle(_ hud: JGProgressHUD, with info: HudInfo) {
        switch info.type {
        case .none:
            return
        case .show:
            show(hud, text: info.text, detailText: info.detailText)
        case .update:
            change(hud, text: info.text, detailText: info.detailText)
        case .success:
            dismiss(hud, type: info.type, text: info.text, detailText: info.detailText)
        case .error:
            dismiss(hud, type: info.type, text: info.text, detailText: info.detailText)
        }
    }
    
    
//    MARK: - HUDを作成
    static func create() -> JGProgressHUD {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }
    
//    MARK: - HUDを表示する
    static func show(_ hud: JGProgressHUD, text: String, detailText: String = "") {
        hud.textLabel.text = text
        if detailText != "" {
            hud.detailTextLabel.text = detailText
        }
        if let topVC = UIApplication.getTopMostViewController() {
            hud.show(in: topVC.view)
        }
    }
    
//    MARK: - HUDを変更
    static func change(_ hud: JGProgressHUD, text: String, detailText: String = "") {
        hud.textLabel.text = text
        if detailText != "" {
            hud.detailTextLabel.text = detailText
        }
    }
    
//    MARK: - HUDを非表示にする
    static func dismiss(_ hud: JGProgressHUD, type: HudType, text: String, detailText: String) {
        hud.textLabel.text = text
        hud.detailTextLabel.text = detailText
        var delay: TimeInterval
        if type == .success {
            delay = TimeInterval(0.5)
        } else {
            delay = TimeInterval(1.0)
        }
        hud.dismiss(afterDelay: delay)
    }
    
    
}

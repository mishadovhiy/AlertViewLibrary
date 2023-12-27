//
//  AlertManager.swift
//  testspm
//
//  Created by Misha Dovhiy on 20.12.2023.
//

import Foundation
import UIKit

public class AlertManager {
    private var alert:AlertViewLibrary!
    
    public init(appearence:AIAppearence? = nil, delegate:AlertViewProtocol? = nil) {
        alert = .init(frame: .zero)//.instanceFromNib(appearence)
        alert.properties = appearence ?? .init()
        let appDelegate = UIApplication.shared.keyWindow
        let height = (appDelegate?.frame.height ?? 0) + 200
        alert.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, height, 0)

        alert.delegate = delegate
    }
    
    /// - Parameters:
    ///  - canIgnore - if ignoreCondition == true: Loader wouldn't be showed
    public func showLoading(title: String? = nil, description: String? = nil, canIgonre:Bool = false, completion: (() -> ())? = nil) {
        alert.showLoading(title: title, description: description, canIgonre: canIgonre, completion: completion)
    }
    
    /// - Parameters:
    ///  - appearence - set nill to show alert with OK button
    public func showAlert(title: String?, description: String? = nil, appearence:AlertViewLibrary.AlertShowMetadata? = nil) {
        alert.showAlert(title: title, description: description, appearence: appearence)
    }
    
    public func hide(completion:(()->())? = nil) {
        alert?.fastHide(completion: completion)
    }
    
    
    public var isShowing:Bool {
        get {
            return alert.isShowing
        }
        set {
            alert.isShowing = newValue
        }
    }
    
    public var canHideAlert:Bool {
        get {
            return alert.canHideAlert
        }
        set {
            alert.canHideAlert = newValue
        }
    }
    
    public func checkUnseenAlerts() {
        alert.checkUnseenAlerts()
    }
    
    
    public var contentView:UIView {
        return alert.mainView
    }
    
    
    public func setIgnorPresentLoader(_ condition:@escaping() -> (Bool)) {
        alert?.ignoreLoaderCondition = condition
    }

    deinit {
        alert = nil
    }
}


public extension AlertManager {
    func showAlertWithOK(title:String, description:String? = nil, viewType:AlertViewLibrary.ViewType = .error, image:AlertViewLibrary.AIImage? = nil, button:AlertViewLibrary.ButtonData? = nil, okTitle:String? = "OK", okPressed:(()->())? = nil) {
        alert.showAlert(title: title, description: description, appearence: .with({
            $0.type = viewType
            $0.image = image
            $0.primaryButton = .with({
                $0.title = okTitle
                $0.style = .error
                if let okPressed {
                    $0.close = true
                    $0.action = okPressed
                }
            })
            $0.secondaryButton = button
        }))
    }
}

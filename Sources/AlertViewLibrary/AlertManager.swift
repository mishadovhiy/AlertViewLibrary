//
//  AlertManager.swift
//  testspm
//
//  Created by Misha Dovhiy on 20.12.2023.
//

import Foundation
import UIKit

final public class AlertManager {
    private var alert:AlertViewLibrary!
    
    public init(appearence:AIAppearence? = nil, delegate:AlertViewProtocol? = nil) {
        alert = .instanceFromNib(appearence)
        alert.delegate = delegate
    }
    
    /// - Parameters:
    ///  - canIgnore - if ignoreCondition == true: Loader wouldn't be showed
    /// - adds self as subview to the UIWindow of active UIWindowScene
    public func showLoading(title: String? = nil, description: String? = nil, canIgonre:Bool = false, completion: (() -> ())? = nil) {
        alert.showLoading(title: title, description: description, canIgonre: canIgonre, completion: completion)
    }
    
    /// - Parameters:
    ///  - appearence - set nill to show alert with OK button
    /// - adds self as subview to the UIWindow of active UIWindowScene
    public func showAlert(title: String?, description: String? = nil, appearence:AlertViewLibrary.AlertShowMetadata? = nil) {
        alert.showAlert(title: title, description: description, appearence: appearence)
    }
    
    /// - removes self from super view
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

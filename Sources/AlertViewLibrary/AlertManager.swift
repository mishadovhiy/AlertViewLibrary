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
        alert = .instanceFromNib(appearence)
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
    
    public func hide(completion:@escaping()->()) {
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
    
    
    public var contentView:UIView {
        return alert.mainView
    }
    
    
    public func setIgnorShowAI(_ condition:@escaping() -> (Bool)) {
        alert?.ignoreLoaderCondition = condition
    }

    deinit {
        alert = nil
    }
}


public extension AlertManager {
    func showAlertWithOK(title:String, description:String? = nil, viewType:AlertViewLibrary.ViewType = .error, button:AlertViewLibrary.ButtonData? = nil, okTitle:String? = "OK") {
        alert.showAlert(title: title, description: description, appearence: .with({
            $0.type = viewType
            $0.primaryButton = .with({
                $0.title = okTitle
                $0.style = .error
            })
            $0.secondaryButton = button
        }))
    }
}

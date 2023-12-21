//
//  AlertManager.swift
//  testspm
//
//  Created by Misha Dovhiy on 20.12.2023.
//

import Foundation

public class AlertManager {
    private var alert:AlertViewLibrary!
    //store here unseen
    
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
    
    
    var isShowing:Bool {
        get {
            return alert.isShowing
        }
        set {
            alert.isShowing = newValue
        }
    }
    
    
    func setIgnorShowAI(_ condition:@escaping() -> (Bool)) {
        alert?.ignoreLoaderCondition = condition
    }

    deinit {
        alert = nil
    }
}
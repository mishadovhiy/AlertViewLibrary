//
//  IndicatorViewAppearence.swift
//  Budget Tracker
//
//  Created by Mikhailo Dovhyi on 31.03.2022.
//  Copyright © 2022 Misha Dovhiy. All rights reserved.
//

import UIKit

extension AlertViewLibrary {
    public func showUnseenAlerts() {
        if let function = viewModel.anshowedAIS.first as? () -> ()  {
            viewModel.anshowedAIS.removeFirst()
            function()
        }
    }
    
    enum ViewKeys:String {
        case verticalSeparetor
    }
    
    public enum ViewType {
        /**
         - higligting background
         */
        case error
        /**
         - higligting background
         */
        case internetError
        case succsess
        case standard
        /**
         - error type without higlight
         */
        case standardError
        case ai
        
        
        var isError:Bool {
            switch self {
            case .error, .internetError, .standardError: return true
            default:return false
            }
        }
    }
    
    
    
    public struct ButtonData {
        public var title: String? = nil
        public var style: ButtonType = .regular
        public var close: Bool = true
        public var action: (() -> ())? = nil
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }

    }
    public enum ButtonType {
        case error
        case regular
        case link
    }
}


extension AlertViewLibrary {
    public struct AlertShowMetadata {
        public var type: ViewType = .standard
        public var image:AIImage? = nil
        public var primaryButton:ButtonData? = nil
        public var secondaryButton:ButtonData? = nil
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    public enum AIImage {
        case error
        case success
        case image(UIImage)
    }

}

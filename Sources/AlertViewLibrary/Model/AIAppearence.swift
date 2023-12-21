//
//  AlertDefaultText.swift
//  AlertView
//
//  Created by Misha Dovhiy on 06.06.2022.
//

import UIKit

public struct AIAppearence {
    /**
     - Parameters:
     - default Text Values
     - setted values would be displeyed if showAlert or showLoading methods would be called without related values
     */
    var defaultText:Text = .init()
    var colors:Colors = .init()
    var images:Images?
    var additionalLaunchProperties:AIProperties?
    var animations:Animations = .init()
    
    public static func with(
        _ populator: (inout Self) throws -> ()
    ) rethrows -> Self {
        var message = Self()
        try populator(&message)
        return message
    }
}


extension AIAppearence {
    struct Animations {
        var performHide1:CGFloat = 0.16
        var performHide2:CGFloat = 0.3
        var setBackground:CGFloat = 0.3
        var generalAnimation:CGFloat = 0.55
        var generalAnimationSpring:CGFloat = 0.85
        var alertShow:CGFloat = 0.3
        var loadingShow1:CGFloat = 0.35
        var loadingShow2:CGFloat = 0.15
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct Images {
        var alertError:UIImage? = nil
        var alertSuccess:UIImage? = nil
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct AIProperties {
        var zPosition:CGFloat?
        var lineWidth:CGFloat?
        var mainCorners:CGFloat?
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    public struct Text {
        var loading:String? = nil
        var standart:String = "Done"
        var internetError:(title:String, description:String) = (title:"Internet error", description:"Try again later")
        var error:String = "Error"
        var okButton:String = "OK"
        var success:String = "Success"
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
}


extension AIAppearence {
    public struct Colors {
        var alertState:AlertStateColors? = nil
        var activityState:loadingStateColors? = nil
        var buttom:ButtonColors? = nil
        var texts:TextColors? = nil
        var separetor:UIColor? = nil
        
        fileprivate init(alertState: AlertStateColors? = nil,
             activityState: loadingStateColors? = nil,
             buttom: ButtonColors? = nil,
             texts: TextColors? = nil,
             separetor: UIColor? = nil) {
            self.alertState = alertState
            self.activityState = activityState
            self.buttom = buttom
            self.texts = texts
            self.separetor = separetor
        }
        
        fileprivate init(_ from:GeneratedAppearence = .init()) {
            let viewRes = from.view ?? UIColor.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
            let loaderViewRes = from.loaderView ?? (from.view ?? UIColor.black)
            let backgroundRes = from.background ?? (from.view ?? UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
            
            self.init(alertState:
                    .init(background:backgroundRes.withAlphaComponent(from.alertBackAlpha),
                          view: viewRes,
                          errorHiglight: .red
                         ),
                         activityState: .init(background: backgroundRes.withAlphaComponent(from.loaderBackAlpha),
                                              view: loaderViewRes),
                         buttom: .init(link: from.buttom?.link ?? .link,
                                       normal: from.buttom?.normal ?? .white),
                         texts: .init(title: from.texts?.title ?? .white,
                                      description: from.texts?.description ?? .systemGray),
                      separetor: from.separetor ?? .gray
            )
        }
        
        fileprivate static var `default`:Colors {
            return .init()
        }
        
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
        
        static func generate(
            _ populator: (inout GeneratedAppearence) throws -> ()
        ) rethrows -> Self {
            var message = GeneratedAppearence()
            try populator(&message)
            return .init(message)
        }
        
        struct GeneratedAppearence {
            var view:UIColor? = nil
            var loaderView:UIColor? = nil
            var background:UIColor? = nil
            var alertBackAlpha:CGFloat = 0.6
            var loaderBackAlpha:CGFloat = 0.2
            var buttom:ButtonColors? = nil
            var texts:TextColors? = nil
            var separetor:UIColor? = nil
            
            public static func with(
                _ populator: (inout Self) throws -> ()
            ) rethrows -> Self {
                var message = Self()
                try populator(&message)
                return message
            }
        }
    }
}


extension AIAppearence {
    
    struct AlertStateColors {
        var background:UIColor? = nil
        var view:UIColor? = nil
        var errorHiglight:UIColor? = nil
        
        fileprivate init(background: UIColor? = nil, view: UIColor? = nil, errorHiglight: UIColor? = nil) {
            self.background = background ?? Colors.default.alertState?.background
            self.view = view ?? Colors.default.alertState?.view
            self.errorHiglight = errorHiglight ?? Colors.default.alertState?.errorHiglight
        }
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct loadingStateColors {
        var background:UIColor? = nil
        var view:UIColor? = nil
        
        fileprivate init(background: UIColor? = nil, view: UIColor? = nil) {
            self.background = background ?? Colors.default.activityState?.background
            self.view = view ?? Colors.default.activityState?.view
        }
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct ButtonColors {
        var link:UIColor? = nil
        var normal:UIColor? = nil
        
        fileprivate init(link: UIColor? = nil, normal: UIColor? = nil) {
            self.link = link ?? Colors.default.buttom?.link
            self.normal = normal ?? Colors.default.buttom?.normal
        }
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct TextColors {
        var title:UIColor? = nil
        var description:UIColor? = nil
        
        fileprivate init(title: UIColor? = nil, description: UIColor? = nil) {
            self.title = title ?? Colors.default.texts?.title
            self.description = description ?? Colors.default.texts?.description
        }
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
}

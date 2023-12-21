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
    public var defaultText:Text = .init()
    public var colors:Colors = .init()
    public var images:Images?
    public var additionalLaunchProperties:AIProperties?
    public var animations:Animations = .init()
    
    public static func with(
        _ populator: (inout Self) throws -> ()
    ) rethrows -> Self {
        var message = Self()
        try populator(&message)
        return message
    }
}


public extension AIAppearence {
    struct Animations {
        public var performHide1:CGFloat = 0.16
        public var performHide2:CGFloat = 0.3
        public var setBackground:CGFloat = 0.3
        public var generalAnimation:CGFloat = 0.55
        public var generalAnimationSpring:CGFloat = 0.85
        public var alertShow:CGFloat = 0.3
        public var loadingShow1:CGFloat = 0.35
        public var loadingShow2:CGFloat = 0.15
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct Images {
        public var alertError:UIImage? = nil
        public var alertSuccess:UIImage? = nil
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct AIProperties {
        public var zPosition:CGFloat?
        public var lineWidth:CGFloat?
        public var mainCorners:CGFloat?
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
    
    struct Text {
        public var loading:String? = nil
        public var standart:String = "Done"
        public var internetError:(title:String, description:String) = (title:"Internet error", description:"Try again later")
        public var error:String = "Error"
        public var okButton:String = "OK"
        public var success:String = "Success"
        
        public static func with(
            _ populator: (inout Self) throws -> ()
        ) rethrows -> Self {
            var message = Self()
            try populator(&message)
            return message
        }
    }
}


public extension AIAppearence {
    struct Colors {
        public var alertState:AlertStateColors? = nil
        public var activityState:loadingStateColors? = nil
        public var buttom:ButtonColors? = nil
        public var texts:TextColors? = nil
        public var separetor:UIColor? = nil
        
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
            
            var linkColor:UIColor!
            if #available(iOS 13.0, *) {
                linkColor = .link
            } else {
                linkColor = .systemBlue
            }
            
            self.init(alertState:
                    .init(background:backgroundRes.withAlphaComponent(from.alertBackAlpha),
                          view: viewRes,
                          errorHiglight: .red
                         ),
                         activityState: .init(background: backgroundRes.withAlphaComponent(from.loaderBackAlpha),
                                              view: loaderViewRes),
                         buttom: .init(link: from.buttom?.link ?? linkColor,
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
        
        public static func generate(
            _ populator: (inout GeneratedAppearence) throws -> ()
        ) rethrows -> Self {
            var message = GeneratedAppearence()
            try populator(&message)
            return .init(message)
        }
        
        public struct GeneratedAppearence {
            public var view:UIColor? = nil
            public var loaderView:UIColor? = nil
            public var background:UIColor? = nil
            public var alertBackAlpha:CGFloat = 0.6
            public var loaderBackAlpha:CGFloat = 0.2
            public var buttom:ButtonColors? = nil
            public var texts:TextColors? = nil
            public var separetor:UIColor? = nil
            
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


public extension AIAppearence {
    
    struct AlertStateColors {
        public var background:UIColor? = nil
        public var view:UIColor? = nil
        public var errorHiglight:UIColor? = nil
        
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
        public var background:UIColor? = nil
        public var view:UIColor? = nil
        
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
        public var link:UIColor? = nil
        public var normal:UIColor? = nil
        
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
        public var title:UIColor? = nil
        public var description:UIColor? = nil
        
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

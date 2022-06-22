//
//  AlertDefaultText.swift
//  AlertView
//
//  Created by Misha Dovhiy on 06.06.2022.
//

import UIKit


public struct AIAppearence {
    let text:Text
    let colors:Colors
    
    init() {
        self.colors = DefaultProperties.colors
        self.text = DefaultProperties.text
    }
    
    public init(text:Text? = nil, colors:Colors? = nil) {
        self.text = text ?? DefaultProperties.text
        self.colors = colors ?? DefaultProperties.colors
    }
    
    public struct Text {
        var loading:String
        var done:String
        var internetError:(title:String, description:String)
        var error:String
        var okButton:String
        var success:String
    }

    public struct Colors {
        let accent:(background:UIColor, view:UIColor, higlight:UIColor)
        let normal:(background:UIColor, view:UIColor)
        let buttom:(link:UIColor, normal:UIColor)
        let texts:(title:UIColor, description:UIColor)
    }
    
    private struct DefaultProperties {
        static var colors:Colors {
            let accent:(background:UIColor, view:UIColor, higlight:UIColor) = (background: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                                               view: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                                               higlight: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            
            let normal:(background:UIColor, view:UIColor) = (background: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                             view: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            
            let buttons:(link:UIColor, normal:UIColor) = (link: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                          normal: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            
            let texts:(title:UIColor, description:UIColor) = (title: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                              description: .init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            return .init(accent: accent,
                         normal: normal,
                         buttom: buttons,
                         texts: texts)
        }
        
        
        
        
        
        static let text:Text = .init(loading: "Loading",
                                     done: "Done",
                                     internetError: (title:"Internet error", description:"Try again later"),
                                     error: "Error",
                                     okButton: "OK",
                                     success: "Success")
    }
    
}




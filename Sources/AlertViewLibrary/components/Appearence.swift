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
    
    public var zPosition:CGFloat?
    
    public init(text:Text, colors:Colors) {
        self.text = text
        self.colors = colors
    }
    
    public struct Text {
        var loading:String
        var done:String
        var internetError:(title:String, description:String)
        var error:String
        var okButton:String
        var success:String
        public init(loading:String = "Loading", done:String = "Done", internetError:(title:String, description:String) = (title:"Internet error", description:"Try again later"), error:String = "Error", okButton:String = "OK", success:String = "Success") {
            self.loading = loading
            self.done = done
            self.internetError = internetError
            self.error = error
            self.okButton = okButton
            self.success = success
        }
    }

    public struct Colors {
        var accent:(background:UIColor, view:UIColor, higlight:UIColor)
        var normal:(background:UIColor, view:UIColor)
        var buttom:(link:UIColor, normal:UIColor)
        var texts:(title:UIColor, description:UIColor)
        var separetor:UIColor
        public init(accent:(background:UIColor, view:UIColor, higlight:UIColor)? = nil,
                    normal:(background:UIColor, view:UIColor)? = nil,
                    buttom:(link:UIColor, normal:UIColor)? = nil,
                    texts:(title:UIColor, description:UIColor)? = nil,
                    separetor:UIColor = .systemGray
        ) {
            

            let defAccent = (background: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                             view: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                             higlight: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            let defNormal = (background: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                                  view: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            let defButtom = (link: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                              normal: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            let defTexts = (title: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60),
                                                                   description: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60))
            self.accent = accent ?? defAccent
            self.normal = normal ?? defNormal
            self.buttom = buttom ?? defButtom
            self.texts = texts ?? defTexts
            self.separetor = separetor
        }
    }
    
    
    
}



extension CALayer {
    func createLine(_ lines:[CGPoint], color:UIColor, width:CGFloat = 0.5, opacity:Float = 0.2) -> CAShapeLayer {
        let line = CAShapeLayer()
        line.path = createPath(lines).cgPath
        line.fillColor = nil
        line.opacity = opacity
        line.lineWidth = width
        line.strokeColor = (color).cgColor
        self.addSublayer(line)
        return line
    }
    
    func drawLine(_ lines:[CGPoint], color:UIColor, width:CGFloat = 0.5, opacity:Float = 0.2) {
        let _ = createLine(lines, color: color, width: width, opacity: opacity)
    }
    
    
    private func createPath(_ lines:[CGPoint]) -> UIBezierPath {
        let linePath = UIBezierPath()
        var liness = lines
        linePath.move(to: liness.first!)
        liness.removeFirst()
        liness.forEach { line in
            linePath.addLine(to: line)
        }
        return linePath
    }
}

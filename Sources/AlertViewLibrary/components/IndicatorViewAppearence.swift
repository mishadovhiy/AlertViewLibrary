//
//  IndicatorViewAppearence.swift
//  Budget Tracker
//
//  Created by Mikhailo Dovhyi on 31.03.2022.
//  Copyright © 2022 Misha Dovhiy. All rights reserved.
//

import UIKit


extension AlertViewLibrary {
    func setBacground(higlight:Bool, ai:Bool) {
        
        DispatchQueue.main.async {
            let higlighten = {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundView.backgroundColor = ai ? self.appearence.colors.normal.background : self.appearence.colors.accent.background
                }
            }
            if higlight {
                UIView.animate(withDuration: 0.3) {
                    self.mainView.layer.shadowOpacity = 0.9
                    self.titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
                    self.backgroundView.backgroundColor = self.appearence.colors.accent.higlight
                } completion: { _ in
                    higlighten()
                }
            } else {
                higlighten()
            }
            
        }
    }
    
    func buttonStyle(_ button:UIButton, type:button) {
        DispatchQueue.main.async {
            button.setTitleColor(self.buttonToColor(type.style), for: .normal)
            button.setTitle(type.title, for: .normal)
            if button.isHidden != false {
                button.isHidden = false
            }
            if button.superview?.isHidden != false {
                button.superview?.isHidden = false
            }
        }
    }
    
    private func buttonToColor(_ type:ButtonType) -> UIColor {
        switch type {
        case .error: return .red
        case .link: return appearence.colors.buttom.link
        case .regular: return appearence.colors.buttom.normal
        }
    }
    
    func getAlertImage(image:UIImage?, type:ViewType) -> UIImage? {
        if let image = image {
            return image
        } else {
            if type == .error || type == .internetError {
                return .init(named: "warning", in: Bundle.module, compatibleWith: nil)
            } else {
                if type == .succsess {
                    return .init(named: "success", in: Bundle.module, compatibleWith: nil)
                }
            }
                                                   
        }
        return nil
    }

    
}

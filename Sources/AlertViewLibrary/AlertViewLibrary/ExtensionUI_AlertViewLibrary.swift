//
//  ExtensionUI_AlertViewLibrary.swift
//  testspm
//
//  Created by Misha Dovhiy on 20.12.2023.
//

import UIKit

extension AlertViewLibrary {
    func loadUI() {
        if separetor != nil {
            return
        }
        viewModel.normalTitleSize = self.titleLabel.font
        self.titleLabel.textColor = properties.colors.texts?.title
        self.descriptionLabel.textColor = properties.colors.texts?.description
        if let zPosition = properties.additionalLaunchProperties?.zPosition {
            self.layer.zPosition = zPosition
        }
        
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = properties.additionalLaunchProperties?.mainCorners ?? 12
        mainView.layer.shadow()
        
        let stackFrame = buttonsStack.layer.frame
        buttonsStack.layer.drawLine([
            .init(x: -20, y: 0), .init(x: stackFrame.width + 40, y: 0)
        ], color: properties.colors.separetor ?? .red, width: properties.additionalLaunchProperties?.lineWidth ?? 0.15, opacity: 1)
        
        let line = buttonsStack.layer.createLine([
            .init(x: stackFrame.width / 2, y: 0), .init(x: stackFrame.width / 2, y: stackFrame.height + 5)
        ], color: properties.colors.separetor ?? .red, width: properties.additionalLaunchProperties?.lineWidth ?? 0.15, opacity: 1)
        line.name = ViewKeys.verticalSeparetor.rawValue
        let _ = self.addBluer(insertAt: 0)
    }
    
    func prepareAlertAppeared(appearence:AlertShowMetadata?) {
        let appearence = appearence ?? .init()
        
        if appearence.type == .error {
            UIImpactFeedbackGenerator().impactOccurred()
        }
        let needHiglight = appearence.type == .error || appearence.type == .internetError
        self.setBackground(higlight: needHiglight, ai: false)
    }
    
    
    func prepareAlertWillAppeare(appearence:AlertShowMetadata?, title: String?, description: String?) {
        let appearence = appearence ?? .init()
        self.canHideAlert = false
        viewModel.leftButtonPressed = (appearence.primaryButton?.action, appearence.primaryButton?.close ?? true)
        var defaultTitle:String?
        switch appearence.type {
        case .error:
            defaultTitle = properties.defaultText.error
        case .internetError, .standardError:
            defaultTitle = properties.defaultText.internetError.title
        case .standard:
            defaultTitle = properties.defaultText.standart
        case .succsess:
            defaultTitle = properties.defaultText.success
        default:
            defaultTitle = nil
        }
        self.titleLabel.text = title ?? defaultTitle
        self.descriptionLabel.text = appearence.type == .internetError ? self.properties.defaultText.internetError.description : description
    }
    
    func performAppeare(title: String, isBlack: Bool, showed: @escaping (Bool) -> ()) {
        if !isShowing {
            isShowing = true
            self.generalAppeare()
            self.backgroundView.isHidden = (false)
            self.titleLabel.isHidden = (false)
            self.mainView.isHidden = (false)
            self.backgroundView.backgroundColor = .clear
            UIView.animate(withDuration: self.properties.animations.generalAnimation, delay: 0, usingSpringWithDamping: self.properties.animations.generalAnimationSpring, initialSpringVelocity: 0, options: .allowAnimatedContent) {
                self.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)
            } completion: {
                if !$0 {
                    return
                }
                self.window.endEditing(true)
                if let delegate = self.delegate {
                    delegate.alertViewWillAppear()
                }
                showed(true)
            }
        } else {
            showed(true)
        }
    }
    
    
    func prepareShowLoading(title:String?) {
        self.isShowing = true
        viewModel.canCloseOnSwipe = false
        self.setBackground(higlight: false, ai: true)
        self.generalAppeare()
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)
        self.buttonsStack.isHidden = (true)
        self.activityIndicatorView.startAnimating()
    }
    
    func performHide(completion: (() -> ())? = nil) {
        UIView.animate(withDuration: self.properties.animations.performHide1) {
            self.backgroundView.backgroundColor = .clear
        }
        UIView.animate(withDuration: self.properties.animations.performHide2, delay: self.properties.animations.performHide1) {
            self.buttonsStack.isHidden = (true)
            self.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, self.window.frame.height + 200, 0)
        } completion: { (_) in
            self.titleLabel.font = self.viewModel.normalTitleSize
            self.removeFromSuperview()
            self.setAllHidden()
            completion?()
            
            if let delegate = self.delegate {
                delegate.alertViewDidDisappear()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.checkUnseenAlerts()
            }
        }
    }
}


//MARK: private
fileprivate extension AlertViewLibrary {
    public override var window: UIWindow {
        return UIApplication.shared.keyWindow ?? .init(frame: .init(origin: .zero, size: .init(width: 50, height: 50)))
    }
    
    private var separetor:CALayer? {
        return buttonsStack.layer.sublayers?.first(where: {$0.name == ViewKeys.verticalSeparetor.rawValue})
    }
    
    private func generalAppeare() {
        self.frame = window.frame
        window.addSubview(self)
        self.isHidden = (false)
        self.alpha = 1
        self.backgroundView.alpha = 1
    }
    
    private func setAllHidden() {
        viewModel.canCloseOnSwipe = false
        isShowing = false
        primaryButton.superview?.isHidden = (true)
        imageView.superview?.isHidden = (true)
    }
    
    private func setBackground(higlight:Bool, ai:Bool) {
        let higlighten = {
            UIView.animate(withDuration: self.properties.animations.setBackground) {
                self.backgroundView?.backgroundColor = ai ? self.properties.colors.activityState?.background : self.properties.colors.alertState?.background
            }
        }
        if higlight {
            UIView.animate(withDuration: self.properties.animations.setBackground) {
                self.mainView?.layer.shadowOpacity = 0.9
                self.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
                self.backgroundView?.backgroundColor = self.properties.colors.alertState?.errorHiglight
            } completion: { _ in
                higlighten()
            }
        } else {
            higlighten()
        }
        
    }
    
    private func setButtonStyle(_ button:UIButton, type:ButtonData?) {
        button.setTitleColor(self.buttonToColor(type?.style ?? .regular), for: .normal)
        button.setTitle(type?.title ?? properties.defaultText.okButton, for: .normal)
        if button.isHidden != false {
            button.isHidden = false
        }
        if button.superview?.isHidden != false {
            button.superview?.isHidden = false
        }
    }
    
    private func buttonToColor(_ type:ButtonType) -> UIColor {
        switch type {
        case .error: return .red
        case .link: return properties.colors.buttom?.link ?? .red
        case .regular: return properties.colors.buttom?.normal ?? .red
        }
    }
    
    private func alertImage(_ image:AIImage?) -> UIImage? {
        switch image {
        case .error:
            return properties.images?.alertError ?? .init(named: "warning", in: nil, compatibleWith: nil)
        case .success:
            return properties.images?.alertSuccess ?? .init(named: "success", in: nil, compatibleWith: nil)
        case .image(let img):
            return img
        case .none:
            return nil
        }
    }
}


//MARK: Animation
extension AlertViewLibrary {
    func showLoaderAnimation(title:String?, description:String?) {
        let hideTitle = title == nil ? true : false
        let hideDescription = (description == "" || description == nil) ? true : false
        mainView.backgroundColor = self.properties.colors.activityState?.view
        activityIndicatorView.superview?.isHidden = (false)
        descriptionLabel.isHidden = (hideDescription)
        titleLabel.isHidden = (hideTitle)
        imageView.image = nil
        imageView.superview?.isHidden = (true)
    }
    
    func showAlertAnimation(appearence:AlertShowMetadata?, description:String?) {
        let appearence = appearence ?? .init()
        let hideDescription = appearence.type == .internetError ? false : ((description == nil || description == "") ? true : false)
        let hideButtonSeparetor = appearence.secondaryButton == nil ? true : false
        
        self.secondaryButton.isHidden = (appearence.secondaryButton == nil)
        if (separetor?.isHidden ?? false) != hideButtonSeparetor {
            separetor?.isHidden = hideButtonSeparetor
        }
        self.mainView.backgroundColor = self.properties.colors.alertState?.view
        
        self.titleLabel.isHidden = (false)
        self.descriptionLabel.isHidden = (hideDescription)
        
        self.primaryButton.superview?.superview?.isHidden = (false)
        self.activityIndicatorView.superview?.isHidden = (true)
        
        if let image = self.alertImage(appearence.image) {
            self.imageView.image = image
            self.imageView.superview?.isHidden = (false)
        } else {
            self.imageView.superview?.isHidden = (true)
        }
        
        self.setButtonStyle(self.primaryButton, type: appearence.primaryButton)
        if let right = appearence.secondaryButton {
            viewModel.rightButtonPressed = (right.action, right.close)
            self.setButtonStyle(self.secondaryButton, type: right)
        }
    }
}

//MARK: extensions
fileprivate extension UIView {
    func addConstaits(_ constants:[NSLayoutConstraint.Attribute:CGFloat], superV:UIView) {
        let layout = superV
        constants.forEach { (key, value) in
            let keyNil = key == .height || key == .width
            let item:Any? = keyNil ? nil : layout
            superV.addConstraint(.init(item: self, attribute: key, relatedBy: .equal, toItem: item, attribute: key, multiplier: 1, constant: value))
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBluer(frame:CGRect? = nil, style:UIBlurEffect.Style = (.init(rawValue: -1000) ?? .regular), insertAt:Int? = nil) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: blurEffect)
        let vibracityView = UIVisualEffectView(effect: blurEffect)
        effectView.contentView.addSubview(vibracityView)
        let constaints:[NSLayoutConstraint.Attribute : CGFloat] = [.leading:0, .top:0, .trailing:0, .bottom:0]
        vibracityView.addConstaits(constaints, superV: effectView)
        if let at = insertAt {
            self.insertSubview(effectView, at: at)
        } else {
            self.addSubview(effectView)
        }
        effectView.addConstaits(constaints, superV: self)
        return effectView
    }
}


fileprivate extension CALayer {
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
    
    
    func shadow(radius:CGFloat = 16, opasity:Float = 0.6, offset: CGSize = .zero) {
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.shadowOpacity = opasity
    }
}


extension UIApplication {
    var keyWindow:UIWindow? {
        if #available(iOS 13.0, *) {
            let scene = connectedScenes.first(where: {
                ($0 as? UIWindowScene)?.activationState == .foregroundActive
            }) as? UIWindowScene
            if #available(iOS 15.0, *) {
                return scene?.keyWindow
            } else {
                return scene?.windows.first(where: {$0.isKeyWindow})
            }
        } else {
            return windows.first(where: {$0.isKeyWindow})
        }

    }
}

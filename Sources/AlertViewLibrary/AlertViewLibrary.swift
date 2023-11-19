import UIKit

public protocol AlertViewProtocol {
    func alertViewWillAppear()
    func alertViewDidDisappear()
}

public class AlertViewLibrary: UIView {
    public var delegate:AlertViewProtocol?
    lazy var appearence = AIAppearence(text: .init(), colors: .init())
    
    @IBOutlet private weak var actionsStack: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    @IBOutlet private weak var aiSuperView: UIView!
    @IBOutlet private weak var ai: UIActivityIndicatorView!
   // @IBOutlet private weak var buttonsSeparetorImage: UIImageView!
    @IBOutlet weak private var imageView: UIImageView!
    
    private var canCloseOnSwipe = false
    public var isShowing = false
    
    private var anshowedAIS: [Any] = []
    private var rightFunc: (Any?, Bool)?
    private var leftFunc: (Any?, Bool)?
    /**
     - ai woudn't show when set so false
     */
    public var hideIndicatorBlockDesibled = true
    private var normalTitleSize: UIFont = .systemFont(ofSize: 0)
    private let errorFont = UIFont.systemFont(ofSize: 32, weight: .bold)
    private var drded = false
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        if !drded {
            drded = true
            self.normalTitleSize = self.titleLabel.font
            self.titleLabel.textColor = appearence.colors.texts.title
            self.descriptionLabel.textColor = appearence.colors.texts.description
            if let zPoz = appearence.zPosition {
                self.layer.zPosition = zPoz
            }
            
            mainView.layer.masksToBounds = true
            mainView.layer.cornerRadius = 12
            mainView.layer.shadow()
            
            let actionStackFrame = actionsStack.layer.frame
            actionsStack.layer.drawLine([
                .init(x: -20, y: 0), .init(x: actionStackFrame.width + 40, y: 0)
            ], color: appearence.colors.separetor, width: 0.15, opacity: 1)
            
            separetor = actionsStack.layer.createLine([
                .init(x: actionStackFrame.width / 2, y: 0), .init(x: actionStackFrame.width / 2, y: actionStackFrame.height + 5)
            ], color: appearence.colors.separetor, width: 0.15, opacity: 1)
            let _ = self.addBluer(insertAt: 0)
        }
        
    }
    private var separetor:CALayer?
    public var notShowingCondition:(() -> (Bool))?
    
    public func show(title: String? = nil, description: String? = nil, appeareAnimation: Bool = false, notShowIfLoggedUser:Bool = false, completion: @escaping (Bool) -> ()) {
        
        if notShowIfLoggedUser && (notShowingCondition?() ?? false) {
            completion(true)
            return
        }
        DispatchQueue.init(label: "\(#function)", qos: .userInteractive).async {
            if !self.hideIndicatorBlockDesibled {
                return
            }
            if !self.isShowing {
                self.isShowing = true
            }
            self.canCloseOnSwipe = false
            let hideTitle = title == nil ? true : false
            let hideDescription = (description == "" || description == nil) ? true : false
            self.setBacground(higlight: false, ai: true)
            DispatchQueue.main.sync {
                let window = UIApplication.shared.keyWindow ?? UIWindow()
                self.frame = window.frame
                window.addSubview(self)
                if self.imageView.superview?.isHidden != true {
                    self.imageView.superview?.isHidden = true
                }
                self.alpha = 1
                self.backgroundView.alpha = 1
                if self.isHidden {
                    self.isHidden = false
                }
                self.titleLabel.text = title
                self.descriptionLabel.text = description
                self.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)
                if !self.actionsStack.isHidden {
                    self.actionsStack.isHidden = true
                }
                self.ai.startAnimating()
                UIView.animate(withDuration: appeareAnimation ? 0.25 : 0.1) {
                    self.mainView.backgroundColor = self.self.appearence.colors.normal.view
                    if self.titleLabel.isHidden != hideTitle {
                        self.titleLabel.isHidden = hideTitle
                    }
                    if self.descriptionLabel.isHidden != hideDescription {
                        self.descriptionLabel.isHidden = hideDescription
                    }
                    if self.aiSuperView.isHidden {
                        self.aiSuperView.isHidden = false
                    }
                    
                } completion: { (_) in
                    UIView.animate(withDuration: 0.15) {
                        self.mainView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)
                    } completion: { (_) in
                        self.aiSuperView.layoutIfNeeded()
                        completion(true)
                    }
                }
                
            }
        }
    }
    
    
    public func showAlert(buttons: (button, button?), title: String? = "Done", description: String? = nil, type: ViewType = .standard, image:UIImage? = nil) {
        if !hideIndicatorBlockDesibled {
            let new = {
                self.showAlert(buttons: buttons, title: title, description:description, type: type)
            }
            self.anshowedAIS.append(new)
            return
        } else {
            
            
            let hideDescription = type == .internetError ? false : ((description == nil || description == "") ? true : false)
            let hideButtonSeparetor = buttons.1 == nil ? true : false
            DispatchQueue.init(label: "showAlert", qos: .userInteractive).async {
                self.hideIndicatorBlockDesibled = false
                self.leftFunc = (buttons.0.action, buttons.0.close)
                self.checkIfShowing(title: title ?? "", isBlack: false) { _ in
                    let needHiglight = type == .error || type == .internetError
                    self.setBacground(higlight: needHiglight, ai: false)
                    self.buttonStyle(self.leftButton, type: buttons.0)
                    if let right = buttons.1 {
                        self.rightFunc = (right.action, right.close)
                        self.buttonStyle(self.rightButton, type: right)
                    }
                    DispatchQueue.main.async {
                        if buttons.1 == nil {
                            if self.rightButton.isHidden != true {
                                self.rightButton.isHidden = true
                            }
                        }
                        if (self.separetor?.isHidden ?? false) != hideButtonSeparetor {
                            self.separetor?.isHidden = hideButtonSeparetor
                        }
                        
                        if type == .error {
                            UIImpactFeedbackGenerator().impactOccurred()
                        }
                        self.titleLabel.text = type == .internetError ? self.appearence.text.internetError.title : title
                        self.descriptionLabel.text = type == .internetError ? self.appearence.text.internetError.description : description
                        let mailImage = image ?? self.getAlertImage(image: image, type: type)
                        UIView.animate(withDuration: 0.20) {
                            self.mainView.backgroundColor = self.appearence.colors.accent.view
                            
                            if self.titleLabel.isHidden != false {
                                self.titleLabel.isHidden = false
                            }
                            if self.descriptionLabel.isHidden != hideDescription {
                                self.descriptionLabel.isHidden = hideDescription
                            }
                            if self.leftButton.superview?.superview?.isHidden != false {
                                self.leftButton.superview?.superview?.isHidden = false
                            }
                            if !self.aiSuperView.isHidden {
                                self.aiSuperView.isHidden = true
                            }
                            if let image = mailImage {
                                self.imageView.image = image
                                self.imageView.superview?.isHidden = false
                            } else {
                                if self.imageView.superview?.isHidden != true {
                                    self.imageView.superview?.isHidden = true
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    
    
    
    
    
    private func checkIfShowing(title: String, isBlack: Bool, showed: @escaping (Bool) -> ()) {
        if !isShowing {
            isShowing = true
            DispatchQueue.main.async {
                let window = UIApplication.shared.keyWindow ?? UIWindow()
                self.frame = window.frame
                window.addSubview(self)
                self.alpha = 1
                self.backgroundView.alpha = 1
                if self.isHidden != false {
                    self.isHidden = false
                }
                self.titleLabel.text = title
                self.alpha = 1
                self.backgroundView.alpha = 1
                if self.backgroundView.isHidden != false {
                    self.backgroundView.isHidden = false
                }
                
                if self.titleLabel.isHidden != false {
                    self.titleLabel.isHidden = false
                }
                
                self.backgroundView.backgroundColor = .clear
                if self.mainView.isHidden != false {
                    self.mainView.isHidden = false
                }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0, options: .allowAnimatedContent) {
                    self.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)
                } completion: { _ in
                    window.endEditing(true)
                    if let delegate = self.delegate {
                        delegate.alertViewWillAppear()
                    }
                    showed(true)
                }
                
            }
        } else {
            showed(true)
        }
    }
    
    
    
    @IBAction private func closePressed(_ sender: UIButton) {
        fastHide()
    }
    
    @IBAction private func buttonPress(_ sender: UIButton) {
        hideIndicatorBlockDesibled = true
        switch sender.tag {
        case 0:
            if let function = leftFunc?.0 as? (Bool) -> () {
                if leftFunc?.1 == true {
                    fastHide { _ in
                        function(true)
                    }
                } else {
                    self.show(appeareAnimation:true) { _ in
                        function(true)
                    }
                }
            } else {
                fastHide()
            }
        case 1:
            if let function = rightFunc?.0 as? (Bool) -> () {
                if rightFunc?.1 == true {
                    fastHide { (_) in
                        function(true)
                    }
                } else {
                    self.show(appeareAnimation:true) { _ in
                        function(true)
                    }
                }
            } else {
                fastHide()
            }
        default:
            break
        }
    }
    
    public func fastHide() {
        fastHide { _ in
            
        }
    }
    
    public func fastHide(completionn: @escaping (Bool) -> ()) {
        if !isShowing {
            completionn(false)
            return
        }
        if !hideIndicatorBlockDesibled {
            return
        }
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow ?? UIWindow()
            UIView.animate(withDuration: 0.10) {
                self.backgroundView.backgroundColor = .clear
            } completion: { (_) in
                UIView.animate(withDuration: 0.25) {
                    if self.actionsStack.isHidden != true {
                        self.actionsStack.isHidden = true
                    }
                    self.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, window.frame.height + 100, 0)
                } completion: { (_) in
                    self.titleLabel.font = self.normalTitleSize
                    self.removeFromSuperview()
                    self.setAllHidden()
                    completionn(true)
                    
                    if let delegate = self.delegate {
                        delegate.alertViewDidDisappear()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.checkUnshowed()
                    }
                    /*
                     if let b = self.bannerBackgroundWas {
                     self.bannerBackgroundWas = nil
                     AppDelegate.shared?.banner.setBackground(clear: b)
                     }
                     */
                }
            }
        }
    }
    private var bannerBackgroundWas:Bool?
    
    public func checkUnshowed() {
        if let function = anshowedAIS.first as? () -> ()  {
            anshowedAIS.removeFirst()
            function()
        }
    }
    
    
    
    
    public class func instanceFromNib(_ appearence:AIAppearence?) -> AlertViewLibrary {
        if let result = UINib(nibName: "AlertView", bundle: Bundle.module).instantiate(withOwner: nil, options: nil).first as? AlertViewLibrary
        {
            if let appearence = appearence {
                result.appearence = appearence
            }
            return result
        } else {
            let window = UIApplication.shared.keyWindow ?? UIWindow()
            let view = AlertViewLibrary(frame: window.frame)
            return view
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canCloseOnSwipe {//if touches != view
            canCloseOnSwipe = false
            self.fastHide()
        }
    }
    
    
    public func setAllHidden() {//mainthread
        canCloseOnSwipe = false
        isShowing = false
        if leftButton.superview?.isHidden != true {
            leftButton.superview?.isHidden = true
        }
        if imageView.superview?.isHidden != true {
            imageView.superview?.isHidden = true
        }
    }
}


extension UIView {
    func addBluer(frame:CGRect? = nil, style:UIBlurEffect.Style = (.init(rawValue: -1000) ?? .regular), insertAt:Int? = nil) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)//prominent//dark//regular
        let bluer = UIVisualEffectView(effect: blurEffect)
        //bluer.frame = frame ?? .init(x: 0, y: 0, width: frame?.width ?? self.frame.width, height: frame?.height ?? self.frame.height)
        // view.insertSubview(blurEffectView, at: 0)
        let vibracity = UIVisualEffectView(effect: blurEffect)
        // vibracity.contentView.addSubview()
        bluer.contentView.addSubview(vibracity)
        let constaints:[NSLayoutConstraint.Attribute : CGFloat] = [.leading:0, .top:0, .trailing:0, .bottom:0]
        vibracity.addConstaits(constaints, superV: bluer)
        if let at = insertAt {
            self.insertSubview(bluer, at: at)
        } else {
            self.addSubview(bluer)
        }
        
        bluer.addConstaits(constaints, superV: self)
        
        return bluer
    }
    func addConstaits(_ constants:[NSLayoutConstraint.Attribute:CGFloat], superV:UIView) {
        let layout = superV
        constants.forEach { (key, value) in
            let keyNil = key == .height || key == .width
            let item:Any? = keyNil ? nil : layout
            superV.addConstraint(.init(item: self, attribute: key, relatedBy: .equal, toItem: item, attribute: key, multiplier: 1, constant: value))
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

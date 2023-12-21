import UIKit

public class AlertViewLibrary: UIView {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    public var delegate:AlertViewProtocol?
    var properties = AIAppearence()
    var ignoreLoaderCondition:(() -> (Bool))?

    var viewModel:AlertLibraryViewModel = .init()
    public var canHideAlert = true
    public var isShowing = false
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        loadUI()
    }
    
    deinit {
        delegate = nil
        self.removeFromSuperview()
    }
    
    /// - Parameters:
    ///  - canIgnore - if ignoreCondition == true: Loader wouldn't be showed
    public func showLoading(title: String? = nil, description: String? = nil, appeareAnimation:Bool = true, canIgonre:Bool = false, completion: (() -> ())? = nil) {
        if canIgonre && (ignoreLoaderCondition?() ?? false) {
            completion?()
            return
        }
        if !self.canHideAlert {
            return
        }
        let title = title ?? properties.defaultText.loading
        prepareShowLoading(title: title)
        UIView.animate(withDuration: appeareAnimation ? properties.animations.loadingShow1 : 0.1) {
            self.showLoaderAnimation(title: title, description: description)
        } completion: { (_) in
            UIView.animate(withDuration: self.properties.animations.loadingShow2) {
                self.mainView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 0)

            } completion: { (_) in
                self.activityIndicatorView.superview?.layoutIfNeeded()
                completion?()
            }
        }
    }
    
    /// - Parameters:
    ///  - appearence - set nill to show alert with OK button
    func showAlert(title: String?, description: String? = nil, appearence:AlertShowMetadata? = nil) {
        if !canHideAlert {
            viewModel.anshowedAIS.append({
                self.showAlert(title: title, description:description,
                               appearence: appearence)
            })
        } else {
            prepareAlertWillAppeare(appearence: appearence, title: title, description: description)
            performAppeare(title: title ?? "", isBlack: false) { _ in
                self.prepareAlertAppeared(appearence: appearence)
                UIView.animate(withDuration: self.properties.animations.alertShow) {
                    self.showAlertAnimation(appearence: appearence, description: description)
                }
            }
        }
    }
    
    public func fastHide(completion: (() -> ())? = nil) {
        if !isShowing {
            completion?()
            return
        }
        if !canHideAlert {
            return
        }
        self.performHide(completion: completion)
    }
    
    
// MARK: IBAction
    @IBAction private func closePressed(_ sender: UIButton) {
        fastHide()
    }
    
    @IBAction private func buttonPressed(_ sender: UIButton) {
        canHideAlert = true
        let hide = sender.tag == 0 ? (viewModel.leftButtonPressed?.1 ?? true) : viewModel.rightButtonPressed?.1
        let action = sender.tag == 0 ? viewModel.leftButtonPressed?.0 : viewModel.rightButtonPressed?.0
        if let function = action {
            if (hide ?? false) {
                fastHide {
                    function()
                }
            } else {
                self.showLoading(appeareAnimation:true) {
                    function()
                }
            }
        } else {
            fastHide()
        }
    }
    
    
// MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public class func instanceFromNib(_ appearence:AIAppearence?) -> AlertViewLibrary {
        if let result = UINib(nibName: "AlertView", bundle: Bundle.module).instantiate(withOwner: nil, options: nil).first as? AlertViewLibrary
        {
            if let appearence {
                result.properties = appearence
            }
            result.backgroundView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, result.window.frame.height + 200, 0)
            return result
        } else {
            let window = UIApplication.shared.keyWindow
            let view = AlertViewLibrary(frame: window?.frame ?? .zero)
            return view
        }
    }
}


extension AlertViewLibrary {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if viewModel.canCloseOnSwipe {
            viewModel.canCloseOnSwipe = false
            self.fastHide()
        }
    }
}


public protocol AlertViewProtocol {
    func alertViewWillAppear()
    func alertViewDidDisappear()
}

//
//  ViewModelAlertViewLibrary.swift
//  testspm
//
//  Created by Misha Dovhiy on 20.12.2023.
//

import UIKit

struct AlertLibraryViewModel {
    var canCloseOnSwipe = false
    var anshowedAIS: [Any] = []
    var rightButtonPressed: ((()->())?, Bool)?
    var leftButtonPressed: ((()->())?, Bool)?
    /**
     - new ai woudn't show when set so false, indeed they would be added to the query to show later
     */
    var normalTitleSize: UIFont = .systemFont(ofSize: 0)
    let errorFont = UIFont.systemFont(ofSize: 32, weight: .bold)
    var bannerBackgroundWas:Bool?    
}

//
//  HSpinnerButton.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 12.02.2022.
//

import Foundation
import UIKit
import SnapKit

fileprivate enum Constants {
    static var spinnerTag = 1000
}

class HSpinnerButton: UIButton {
    
    public func showSpinner() {
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.tag = Constants.spinnerTag
    
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        

        self.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
            
        }
    }
    
    public func hideSpinner() {
        if let background = viewWithTag(Constants.spinnerTag){
              background.removeFromSuperview()
          }
          self.isUserInteractionEnabled = true
    }
}

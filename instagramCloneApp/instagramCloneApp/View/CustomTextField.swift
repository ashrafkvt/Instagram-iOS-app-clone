//
//  CustomTextField.swift
//  instagramCloneApp
//
//  Created by Ashraf on 24/02/22.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        borderStyle = .none
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        keyboardAppearance = .dark
        setHeight(50)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


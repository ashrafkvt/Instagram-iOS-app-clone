//
//  AuthenticationViewModel.swift
//  instagramCloneApp
//
//  Created by Ashraf on 25/02/22.
//

import Foundation
import UIKit

protocol FormViewModel{
    func updateForm()
}

protocol AuthenticationViewModel{
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel{
    var email: String?
    var password: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor{
        return formIsValid ? UIColor(red: 0.26, green: 0.32, blue: 0.68, alpha: 1.00) : UIColor(red: 0.65, green: 0.29, blue: 0.98, alpha: 0.5)
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 1.0, alpha: 0.67)
    }
}

struct RegisterViewModel: AuthenticationViewModel{
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(red: 0.26, green: 0.32, blue: 0.68, alpha: 1.00) : UIColor(red: 0.65, green: 0.29, blue: 0.98, alpha: 0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? UIColor(white: 1.0, alpha: 1.0) : UIColor(white: 1.0, alpha: 0.67)
    }
    
    
}

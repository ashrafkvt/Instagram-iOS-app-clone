//
//  RegisterController.swift
//  instagramCloneApp
//
//  Created by Ashraf on 24/02/22.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate{
    
//    MARK: - Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.returnKeyType = .next
        
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.returnKeyType = .next
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let fullNameTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Fullname", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.returnKeyType = .next
        
        return tf
    }()
    
    private let userNameTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.returnKeyType = .done
        
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.configureButtonAppearance()
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Already have an account?  ", secondPart: "Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fullNameTextField.delegate = self
        userNameTextField.delegate = self
        
    }
    
//    MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBasedNextTextField(textField: textField)
        return true
    }
    
//    MARK: - Actions
    
    @objc func handleShowLogin(){
        self.navigationController?.popViewController(animated: true)
    }
    
//    MARK: - Helpers
    
    func configureUi(){
        self.configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView: UIStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func switchBasedNextTextField(textField: UITextField){
        switch textField{
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.fullNameTextField.becomeFirstResponder()
        case self.fullNameTextField:
            self.userNameTextField.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
    }
    
    
}



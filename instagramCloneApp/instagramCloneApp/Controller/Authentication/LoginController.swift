//
//  LoginController.swift
//  instagramCloneApp
//
//  Created by Ashraf on 24/02/22.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate{
    
//    MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.returnKeyType = .next
        tf.autocapitalizationType = .none
        
        
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.configureButtonAppearance()
        button.backgroundColor = UIColor(red: 0.65, green: 0.29, blue: 0.98, alpha: 0.5)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Forgot your password?  ", secondPart: "Get help signing in.")

        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(firstPart: "Don't have an account?  ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        configureUi()
        configureNotificationObservers()
        
    }
    
//    MARK: - UITextFielddelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField: textField)
        return true
    }
    
//    MARK: - Actions
    
    @objc func handleShowSignUp(){
        let controller = RegisterController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogIn(){
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
        AuthService.logInUser(email: email, password: password) { result, error in
            if let error = error{
                print("DEBUG: - Failed to log in user \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }
        else{
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
//    MARK: - Helpers
    
    func configureUi(){
        self.navigationController?.navigationBar.isHidden = true
        self.configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func switchBasedNextTextField(textField: UITextField){
        switch textField{
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

//  MARK: - FormViewModel

extension LoginController: FormViewModel{
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
    
}

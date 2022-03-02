//
//  RegisterController.swift
//  instagramCloneApp
//
//  Created by Ashraf on 24/02/22.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate{
    
//    MARK: - Properties
    
    private var viewModel = RegisterViewModel()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelection), for: .touchUpInside)
        return button
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
    
    private let usernameTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.returnKeyType = .done
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 0.65, green: 0.29, blue: 0.98, alpha: 0.5)
        button.configureButtonAppearance()
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        configureNotificationObservers()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fullNameTextField.delegate = self
        usernameTextField.delegate = self
        
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
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }
        else if sender == passwordTextField{
            viewModel.password = sender.text
        }
        else if sender == fullNameTextField{
            viewModel.fullname = sender.text
        }
        else{
            viewModel.username = sender.text
        }
        
        updateForm()
        
    }
    
    @objc func handleProfilePhotoSelection(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    @objc func handleSignUp(){
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullNameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = self.profileImage else {return}
        
        let credentials = AuthCredentials(email: email, password: password,
                                          fullname: fullname, username: username,
                                          profileImage: profileImage)
        
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error{
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully registered the user")
        }
    
    }
    
//    MARK: - Helpers
    
    func configureUi(){
        self.configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView: UIStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, usernameTextField, signUpButton])
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
            self.usernameTextField.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

//  MARK: - FormViewModel

extension RegisterController: FormViewModel{
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

//MARK: - UIImagePickerControllerDelegate

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        
        self.profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}



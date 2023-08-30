//
//  ProfileVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 30.08.23.
//

import UIKit

final class ProfileVC: BaseViewController {
    // Button
    @IBOutlet private var updateeButton: UIButton!
    
    // Text fields
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var nameTF: UITextField!
    @IBOutlet private var passwordTF: UITextField!
    @IBOutlet private var confirmPasswordTF: UITextField!
    
    //views
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    
 
    // validator
    private var isValidEmail = false { didSet { updateContinueButtonState() } }
    private var isConfPassword = false { didSet { updateContinueButtonState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueButtonState() } }
    
    private func setupUI() {
        updateeButton.layer.cornerRadius = updateeButton.frame.size.height / 2
        updateeButton.layer.masksToBounds = true
       
        let personIcon = UIImage(systemName: "person.crop.circle")
        let personImageView = UIImageView(image: personIcon)
        personImageView.contentMode = .center
        personImageView.tintColor = UIColor.systemGray4
        nameTF.leftView = personImageView
        nameTF.leftViewMode = .always
        
        let emailIcon = UIImage(systemName: "envelope.circle")
        let emaiImageView = UIImageView(image: emailIcon)
        emaiImageView.contentMode = .center
        emaiImageView.tintColor = UIColor.systemGray4
        emailTF.leftView = emaiImageView
        emailTF.leftViewMode = .always
        
        let passwordIcon = UIImage(systemName: "lock.circle")
        let passwordImageView = UIImageView(image: passwordIcon)
        passwordImageView.contentMode = .center
        passwordImageView.tintColor = UIColor.systemGray4
        passwordTF.leftView = passwordImageView
        passwordTF.leftViewMode = .always

       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
       
    }

    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty, VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        setupStrongIndicatorsViews()
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passwordText = sender.text, !passwordText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passwordText)
        } else {
            passwordStrength = .veryWeak
        }
        setupStrongIndicatorsViews()
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPasswordText = sender.text, !confPasswordText.isEmpty,
           let passwordText = passwordTF.text, !passwordText.isEmpty
        {
            isConfPassword = VerificationService.isPassConfirm(pass1: passwordText, pass2: confPasswordText)
        } else {
            isConfPassword = false
        }
    }
    
    @IBAction func continueButtonAction() {
        if let email = emailTF.text,
              let password = passwordTF.text
           {
               let userModel = UserModel(name: nameTF.text, email: email, pass: password)
               performSegue(withIdentifier: "goToVerificationScreen", sender: userModel)
           }
       }
    
    private func setupStrongIndicatorsViews()  {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    private func updateContinueButtonState() {
        updateeButton.isEnabled = isValidEmail && isConfPassword && passwordStrength != .veryWeak
    }

    
}

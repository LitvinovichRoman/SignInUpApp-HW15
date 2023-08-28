//
//  SignUpVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 23.08.23.
//

import UIKit

final class SignUpVC: BaseViewController {
    //Button
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private weak var continueButton: UIButton!
    
    //Error label
    @IBOutlet private var emailErrorLabel: UILabel!
    @IBOutlet private var passErrorLabel: UILabel!
    @IBOutlet private var confirmPassError: UILabel!
    
    //Text fields
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var nameTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField! { didSet { showButtonTapped() } }
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    
    //view
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var substrateView: UIView!
    
    //indicator
    @IBOutlet private var strongPassIndicatorsViews: [UIView]!
    
    //validator
    private var isValidEmail = false { didSet { updateContinueButtonState() } }
    private var isConfPassword = false { didSet { updateContinueButtonState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueButtonState() } }
    
    private func setupUI() {
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.masksToBounds = true
        
        continueButton.layer.cornerRadius = continueButton.frame.size.height / 2
        continueButton.layer.masksToBounds = true
       
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
        
        substrateView.layer.cornerRadius = 30
        substrateView.layer.masksToBounds = true
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }

    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty, VerificationService.isValidEmail(email: email)
        {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        emailErrorLabel.isHidden = isValidEmail
        setupStrongIndicatorsViews()
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passwordText = sender.text, !passwordText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passwordText)
        } else {
            passwordStrength = .veryWeak
        }
        passErrorLabel.isHidden = passwordStrength != .veryWeak
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
        confirmPassError.isHidden = isConfPassword
    }
    
  
    
    @IBAction func continueButtonAction() {
        if let email = emailTF.text,
           let password = passwordTF.text,
           let name = nameTF.text
        {
            let userModel = UserModel(name: name, email: email, pass: password)
            performSegue(withIdentifier: "goToVerificationScreen", sender: userModel)
        }
    }
    
    private func setupStrongIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    private func updateContinueButtonState() {
           continueButton.isEnabled = isValidEmail && isConfPassword && passwordStrength != .veryWeak
       }
// нужен fix
    @objc private func showButtonTapped() {
          
          let showButton = UIButton(type: .custom)
          showButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .normal)
          showButton.tintColor = .gray
          showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)

          passwordTF.rightView = showButton
          passwordTF.rightViewMode = .always
        
          if passwordTF.isSecureTextEntry {
              passwordTF.isSecureTextEntry = false // Показать скрытое содержимое
              showButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
          } else {
              passwordTF.isSecureTextEntry = true // Скрыть содержимое
              showButton.setImage(UIImage(systemName: "eye.slash.circle.fill"), for: .normal)
          }
      }

    
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
       
    
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
    
}

//
//  ProfileVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 30.08.23.
//

import UIKit

final class ProfileVC: BaseViewController, UIGestureRecognizerDelegate {
    //model
    var userModel: UserModel?
    
    // Button
    @IBOutlet private var updateButton: UIButton!
    @IBOutlet private weak var showPassButton: UIButton!

    
    // Text fields
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var nameTF: UITextField!
    @IBOutlet private var passwordTF: UITextField!
    @IBOutlet private var confirmPasswordTF: UITextField!
    
    // Error label
    @IBOutlet private var emailErrorLabel: UILabel!
    @IBOutlet private var passErrorLabel: UILabel!
    @IBOutlet private var confirmPassError: UILabel!
    
    // view
    @IBOutlet var strongPassIndicatorsViews: [UIView]!

 
    // validator
    private var isValidEmail = false { didSet { updateButtonState() } }
    private var isConfPassword = false { didSet { updateButtonState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateButtonState() } }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    
    @objc func hideKeyboardOnSwipeDown() {
            view.endEditing(true)
        }
    
    private func setupUI() {
        updateButton.layer.cornerRadius = updateButton.frame.size.height / 2
        updateButton.layer.masksToBounds = true
       
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
        
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }


       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
                swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
                self.view.addGestureRecognizer(swipeDown)
        
    }

    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty, VerificationService.isValidEmail(email: email) {
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
        updateButton.isEnabled = true
        if let confPasswordText = sender.text, !confPasswordText.isEmpty,
           let passwordText = passwordTF.text, !passwordText.isEmpty
        {
            isConfPassword = VerificationService.isPassConfirm(pass1: passwordText, pass2: confPasswordText)
        } else {
            isConfPassword = false
        }
        confirmPassError.isHidden = isConfPassword
    }
    
    @IBAction func updateButtonAction() {
        updateButton.isEnabled = true

        if let email = emailTF.text,
           let password = passwordTF.text,
           let name = nameTF.text
        {
            let userModel = UserModel(name: name, email: email, pass: password)
            let _: () = UserDafultsService.saveUserModel(userModel: userModel)
            
            let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "InfoVС") as? InfoVC else { return }
            
            vc.userModel = userModel
       }
    }

    
    private func updateButtonState() {
        updateButton.isEnabled = isValidEmail && isConfPassword && passwordStrength != .veryWeak
        
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
 
    @IBAction func showButtonTaped(_ sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
                if passwordTF.isSecureTextEntry {
                    if let image = UIImage(systemName: "eye.fill") {
                        sender.setImage(image, for: .normal)
                    }
                } else {
                    if let image = UIImage(systemName: "eye.slash.fill") {
                        sender.setImage(image, for: .normal)
                    }
                }
            }

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
    
}

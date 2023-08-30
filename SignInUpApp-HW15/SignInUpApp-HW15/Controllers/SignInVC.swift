//
//  SignInVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 23.08.23.
//

import UIKit

final class SignInVC: BaseViewController {
    @IBOutlet private var passwordTF: UITextField!
    @IBOutlet private var emailTF: UITextField!
    @IBOutlet private var signInButton: UIButton!
    @IBOutlet private var errorLabel: UILabel! {
        didSet { errorLabel.isHidden = true }
    }
    @IBOutlet weak var showButton: UIButton!
    
    private func setupUI() {
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }
        
    @IBAction func signInAction() {
        errorLabel.isHidden = true
        guard let email = emailTF.text,
              let pass = passwordTF.text,
              let userModel = UserDafultsService.getUserModel(),
              email == userModel.email,
              pass == userModel.pass
        else {
            errorLabel.isHidden = false
            return
        }
            
        goToTabBarController()
    }
    
    private func goToTabBarController() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
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
}





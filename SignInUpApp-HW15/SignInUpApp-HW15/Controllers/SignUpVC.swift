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
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var confirmPasswordTF: UITextField!
    
    //Scroll view
    @IBOutlet private weak var scrollView: UIScrollView!
    
    //indicator
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    
    private func setupUI() {
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.masksToBounds = true
        
        continueButton.layer.cornerRadius = continueButton.frame.size.height / 2
        continueButton.layer.masksToBounds = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
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
       
    
    
    
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

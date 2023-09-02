//
//  VerificationsVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 28.08.23.
//

import UIKit

final class VerificationsVC: BaseViewController {
    
     var userModel: UserModel?
    
    private let randomInt = Int.random(in: 100000 ... 999999)
    var sleepTime = 3
    
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var subView: UIView!
    @IBOutlet private var errorCodeLbl: UILabel!
    @IBOutlet private var codeTF: UITextField!
    @IBOutlet private var centerYConstraint: NSLayoutConstraint!
    
    private func setupUI() {
        subView.layer.cornerRadius = 30
        subView.layer.masksToBounds = true
        
        infoLabel.text = "Please enter code '\(randomInt)' from \(userModel?.email ?? "")"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        setupUI()
    }
    
    @IBAction func codeTFAction(_ sender: UITextField) {
        errorCodeLbl.isHidden = true
        guard let text = sender.text,
              !text.isEmpty,
              text == randomInt.description
        else {
            errorCodeLbl.isHidden = false
            sender.isUserInteractionEnabled = false
            errorCodeLbl.text = "Error code. Please wait \(sleepTime) seconds"
            
            let dispatcAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispatcAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errorCodeLbl.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        performSegue(withIdentifier: "goToHelloScreen", sender: nil)
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
      
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant -= keyboardSize.height / 2
    }
      
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant += keyboardSize.height / 2
    }
      
    // MARK: - Navigation
    
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if let helloVC = segue.destination as? HelloVC {
                 helloVC.userModel = userModel
             }
         }
     
}

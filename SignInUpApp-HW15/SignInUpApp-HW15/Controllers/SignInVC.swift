//
//  SignInVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 23.08.23.
//

import UIKit

final class SignInVC: BaseViewController {
    
    @IBOutlet weak private var passwordTF: UITextField!
    @IBOutlet weak private var emailTF: UITextField!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var errorLabel: UILabel! {
        didSet { errorLabel.isHidden = true }
    }
    
    private func setupUI(){
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        loginButton.layer.masksToBounds = true
        loginButton.isEnabled = false
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
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

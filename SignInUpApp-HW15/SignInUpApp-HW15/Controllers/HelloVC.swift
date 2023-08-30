//
//  HelloVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 28.08.23.
//

import UIKit

final class HelloVC: UIViewController {
    
    var userModel: UserModel?
    
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var subView: UIView!
    @IBOutlet private var continueButton: UIButton!

    private func setupUI() {
        subView.layer.cornerRadius = 30
        subView.layer.masksToBounds = true

        continueButton.layer.cornerRadius = continueButton.frame.size.height / 2
        continueButton.layer.masksToBounds = true

        if let userName = userModel?.name {
                   infoLabel.text = "\(userName) to our Cool App"
               } else {
                   infoLabel.text = "Welcome to our Cool App"
               }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func continueButtonAction() {
        guard let userModel = userModel else { return }
                UserDafultsService.saveUserModel(userModel: userModel)
                navigationController?.popToRootViewController(animated: true)
            }
    }

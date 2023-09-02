//
//  WelcomeVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 23.08.23.
//

import UIKit

final class WelcomeVC: UIViewController {
    @IBOutlet private var createNewAccButton: UIButton!
    @IBOutlet private var signInButton: UIButton!

    private func setupUI() {
        createNewAccButton.layer.cornerRadius = createNewAccButton.frame.size.height / 2
        createNewAccButton.layer.masksToBounds = true

        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.masksToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

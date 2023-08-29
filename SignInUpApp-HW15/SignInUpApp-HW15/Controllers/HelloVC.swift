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

        if let userName = userModel?.userName {
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
        navigationController?.popToRootViewController(animated: true)
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

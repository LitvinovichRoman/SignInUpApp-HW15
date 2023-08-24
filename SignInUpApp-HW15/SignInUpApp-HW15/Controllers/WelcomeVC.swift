//
//  WelcomeVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 23.08.23.
//

import UIKit

final class WelcomeVC: UIViewController {

    @IBOutlet private weak var createNewAccButton: UIButton!
    @IBOutlet private weak var signInButton: UIButton!
    
    private func setupUI(){
        createNewAccButton.layer.cornerRadius = createNewAccButton.frame.size.height / 2
        createNewAccButton.layer.masksToBounds = true
        
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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

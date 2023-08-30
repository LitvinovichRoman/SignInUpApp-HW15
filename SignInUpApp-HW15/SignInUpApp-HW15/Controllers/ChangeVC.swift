//
//  ChangeVC.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 31.08.23.
//

import UIKit

class ChangeVC: UIViewController {

    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.layer.cornerRadius = deleteButton.frame.size.height / 2
        deleteButton.layer.masksToBounds = true
        
        updateButton.layer.cornerRadius = updateButton.frame.size.height / 2
        updateButton.layer.masksToBounds = true
        
        logoutButton.layer.cornerRadius = logoutButton.frame.size.height / 2
        logoutButton.layer.masksToBounds = true
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

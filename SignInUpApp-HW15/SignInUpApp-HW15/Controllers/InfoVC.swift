//
//  InfoVС.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 30.08.23.
//

import UIKit

final class InfoVC: UIViewController {
    
     var userModel: UserModel?
    
    @IBOutlet private weak var subView: UIView!
    
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var emailLbl: UILabel!
   
    
    private func setupUI(){
        subView.layer.cornerRadius = 30
        subView.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showInfo()
    }
  
    
     func showInfo() {
        let userInfo = UserDafultsService.getUserModel()
        if let userInfo = userInfo {
            nameLbl.text = "Name - \(userInfo.name ?? " Name - emty")"
            emailLbl.text = "Email - \(userInfo.email)"
        } else {
            nameLbl.text = "Name - Empty"
            emailLbl.text = "Email - Empty"
        }
    }
}

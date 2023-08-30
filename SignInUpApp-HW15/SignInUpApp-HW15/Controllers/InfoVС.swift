//
//  InfoVС.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 30.08.23.
//

import UIKit

class InfoVС: UIViewController {
    var userModel: UserModel?
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
   
    
    private func setupUI(){
        subView.layer.cornerRadius = 30
        subView.layer.masksToBounds = true
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

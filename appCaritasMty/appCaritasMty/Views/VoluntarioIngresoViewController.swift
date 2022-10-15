//
//  VoluntarioIngresoViewController.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 07/09/22.
//

import UIKit

class VoluntarioIngresoViewController: UIViewController {
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var MenuVolunteer: UIView!
    var backButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.title = "Back"
        backButton.isEnabled = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        MenuVolunteer.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        
        btnSignIn.layer.borderWidth = 1
        btnSignIn.layer.borderColor = UIColor(rgb: 0xFFAF80).cgColor
        btnSignIn.layer.cornerRadius = 10
    }

    
    @IBAction func btnLogIn(_ sender: UIButton) {
    }
    

}

//
//  LoginViewController.swift
//  FB Workshop
//
//  Created by Adithya Narasinghe on 10/4/18.
//  Copyright © 2018 DevCColombo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // TODO: - Add AccountKit Fields
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var imgPhone: UIImageView!
    
    var fromAccountKit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Add Account Kit fields init
        
        imgPhone.image = imgPhone.image!.withRenderingMode(.alwaysTemplate)
        imgPhone.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnFacebook.layer.cornerRadius = 5
        self.btnEmail.layer.cornerRadius = 5
    }
    
    // MARK: - Actions
    @IBAction func btnFacebook_Tap(_ sender: Any) {
        // TODO: - Add Login with facebook Logic
        
        self.performSegue(withIdentifier: "showInterests", sender: nil)
        
    }
    
    @IBAction func btnEmail_Tap(_ sender: Any) {
        // TODO: - Add Login with email Logic
        self.performSegue(withIdentifier: "showInterests", sender: nil)
    }
    
    @IBAction func btnPhone_Tap(_ sender: Any) {
        // TODO: - Add Login with mobile Logic
        self.performSegue(withIdentifier: "showInterests", sender: nil)
    }
    
    // TODO: - Add Account Kit view controller preparation function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInterests" {
            if let viewController = segue.destination as? InterestViewController {
                viewController.setup(forAccountKit: self.fromAccountKit)
            }
        }
    }
    
    
    
}

// TODO: - Add Account Kit extension





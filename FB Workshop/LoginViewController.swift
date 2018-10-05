//
//  LoginViewController.swift
//  FB Workshop
//
//  Created by Adithya Narasinghe on 10/4/18.
//  Copyright © 2018 DevCColombo. All rights reserved.
//

import UIKit
import FacebookLogin
import AccountKit

class LoginViewController: UIViewController {
    
    fileprivate var accountKit = AKFAccountKit(responseType: .accessToken)
    fileprivate var pendingLoginViewController: AKFViewController? = nil
    fileprivate var showAccountOnAppear = false
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var btnPhone: UIButton!
    
    var fromAccountKit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAccountOnAppear = accountKit.currentAccessToken != nil
        pendingLoginViewController = accountKit.viewControllerForLoginResume()
        
        imgPhone.image = imgPhone.image!.withRenderingMode(.alwaysTemplate)
        imgPhone.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnFacebook.layer.cornerRadius = 5
        self.btnEmail.layer.cornerRadius = 5
        self.btnPhone.layer.cornerRadius = 5
    }
    
    // MARK: - Actions
    @IBAction func btnFacebook_Tap(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                self.fromAccountKit = false
                self.performSegue(withIdentifier: "showInterests", sender: nil)
            }
        }
    }
    
    @IBAction func btnEmail_Tap(_ sender: Any) {
        let viewController = accountKit.viewControllerForEmailLogin(withEmail: nil, state: nil)
        prepareLoginViewController(viewController)
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func btnPhone_Tap(_ sender: Any) {
        let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: nil)
        prepareLoginViewController(viewController)
        present(viewController, animated: true, completion: nil)
    }
    
    
    fileprivate func prepareLoginViewController(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
        
        loginViewController.enableSendToFacebook = true
        loginViewController.enableGetACall = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInterests" {
            if let viewController = segue.destination as? InterestViewController {
                viewController.setup(forAccountKit: self.fromAccountKit)
            }
        }
    }
    
    
    
}

extension LoginViewController: AKFViewControllerDelegate {
    func viewController(_ viewController: (UIViewController & AKFViewController)!,
                        didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        self.fromAccountKit = true
        self.performSegue(withIdentifier: "showInterests", sender: nil)
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        self.fromAccountKit = true
        self.performSegue(withIdentifier: "showInterests", sender: nil)
        
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        print("\(String(describing: viewController)) did fail with error: \(String(describing: error))")
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        print("canceled")
    }
}




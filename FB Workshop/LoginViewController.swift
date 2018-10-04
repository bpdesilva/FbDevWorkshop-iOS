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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAccountOnAppear = accountKit.currentAccessToken != nil
        pendingLoginViewController = accountKit.viewControllerForLoginResume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnFacebook.layer.cornerRadius = 5
        self.btnEmail.layer.cornerRadius = 5
    }
    
    // MARK: - Actions
    @IBAction func btnFacebook_Tap(_ sender: Any) {
        self.performSegue(withIdentifier: "showInterests", sender: nil)
        return
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print(grantedPermissions)
                print(declinedPermissions)
                print(accessToken)
                print("Logged in!")
                self.performSegue(withIdentifier: "showInterests", sender: nil)
            }
        }
    }
    
    @IBAction func btnEmail_Tap(_ sender: Any) {
        let viewController = accountKit.viewControllerForEmailLogin(withEmail: nil, state: nil)
        prepareLoginViewController(viewController)
        present(viewController, animated: true, completion: nil)
    }
    
    fileprivate func prepareLoginViewController(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
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


extension LoginViewController: AKFViewControllerDelegate {
    private func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("Login succeded")
    }
    
    private func viewController(_ viewController: UIViewController!, didFailWithError error: Error!) {
        print("\(String(describing: viewController)) did fail with error: \(error)")
    }
}

//
//  RegisterViewController.swift
//  Simi
//
//  Created by Mira Estil on 2/3/18.
//  Copyright © 2018 ME. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    private var fbManager = FirebaseUserManager.manager

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func finishButtonTapped(_ sender: Any) {
        print("finish button tapped - create user")
        guard let email = emailLabel.text,
            let password = passwordLabel.text else {
                return
        }
        
        let user = AppUser(email: email, password: password)
        fbManager.createUser(user: user) { [weak self] in
            let homeVC = HomepageViewController.instantiate(fromAppStoryboard: .HomepageViewController)
            let profileVC = ProfileViewController.instantiate(fromAppStoryboard: .ProfileViewController)
            let navController = UINavigationController(rootViewController: homeVC)
            
            let tabBar = UITabBarController()
            tabBar.setViewControllers([navController, profileVC], animated: true)
            
            self?.present(tabBar, animated: true, completion: nil)
        }
    }
    
}

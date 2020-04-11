//
//  MainNavigationController.swift
//  audible
//
//  Created by Brian Voong on 9/27/16.
//  Copyright © 2016 Lets Build That App. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        isNavigationBarHidden = true
        if isLoggedIn() {
            //assume user is logged in
            let homeController = HomeController()
            viewControllers = [homeController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = SwipingController()
//        present(loginController, animated: true, completion: {
//            //perhaps we'll do something here later
//        })
        pushViewController(loginController, animated: true)
    }
}







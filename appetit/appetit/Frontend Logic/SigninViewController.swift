//
//  SigninViewController.swift
//  appetit
//
//  Created by Frank Hu on 3/28/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//


import UIKit

class SigninViewController: UIViewController {
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: SwipingControllerDelegate?
    
    @objc func createAccount() {
        delegate?.finishLoggingIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }

}




//
//  popup.swift
//  TinderSwipe
//
//  Created by Frank Hu on 4/16/20.
//  Copyright © 2020 Frank Hu. All rights reserved.
//


import UIKit

class Popup: UIView, UIGestureRecognizerDelegate {
    
    fileprivate let updateButton: LoadingButton = {
        let button = LoadingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 0.988, green: 0.957, blue: 0.925, alpha: 1)
        button.setTitle("Update", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        return button

    }()
    
    fileprivate let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 220/256, green: 220/256, blue: 220/256, alpha: 1)
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        return button

    }()
    
    fileprivate let nametextfield: UITextField = {
        let u = UITextField()
        u.translatesAutoresizingMaskIntoConstraints = false
        u.borderStyle = UITextField.BorderStyle.line
        u.borderStyle = .roundedRect
        
        // Set UITextField background colour
        u.backgroundColor = UIColor.white
        u.text = "Avocado"
        return u
    }()
    
    fileprivate let servingtextfield: UITextField = {
        let u = UITextField()
        u.translatesAutoresizingMaskIntoConstraints = false
        u.borderStyle = UITextField.BorderStyle.line
        u.borderStyle = .roundedRect
        
        // Set UITextField background colour
        u.backgroundColor = UIColor.white
        u.text = "2"
        return u
    }()
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    }()
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nametextfield, servingtextfield, updateButton, deleteButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 7
        return stack
    }()
    
    @objc fileprivate func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete{
                self.removeFromSuperview()
            }
        }
    }
    
    @objc fileprivate func animateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)

        //code below to make modal not disappear on touch of container
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        
        container.addSubview(stack)
        //stack.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        //stack.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        //stack.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.9).isActive = true
        

        
        
        animateIn()


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         return touch.view == gestureRecognizer.view
    }
}
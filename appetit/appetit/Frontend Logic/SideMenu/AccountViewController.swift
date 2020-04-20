//
//  AccountViewController.swift
//  SandBox
//
//  Created by Tommy Hessel on 4/19/20.
//  Copyright © 2020 Tommy Hessel. All rights reserved.
//

import UIKit

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

class AccountViewController: UIViewController {
    
    var currentemail = String()
    var currentpassword = String()
    var currentfirstname = String()
    var currentlastname = String()
    var currentcal = String()
    
    var backPanel: UIView = {
        let bp = UIView()
        bp.translatesAutoresizingMaskIntoConstraints = false
        bp.backgroundColor =  UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        return bp //red: 246/255, green: 246/255, blue: 246/255, alpha: 1
    }()
    var logo: UIImageView = {
        let l = UIImageView(image: UIImage(named: "Appetit"))
        l.translatesAutoresizingMaskIntoConstraints = false
        l.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        l.contentMode = .scaleAspectFit
        return l
    }()
    var profPic: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profile"))
        image.makeRounded()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Tommy Hessel"
        name.font = .boldSystemFont(ofSize: 30)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name //red: 246/255, green: 246/255, blue: 246/255, alpha: 1
    }()
        var changeName: UIButton = {
        let cn = UIButton()
        let Bcolor = UIColor.white
        cn.setTitle("Change Email", for: .normal)
        cn.titleLabel?.font =  UIFont(name: "boldSystemFont", size:25)
        cn.setTitleColor (Bcolor, for: .normal)
        cn.translatesAutoresizingMaskIntoConstraints = false
        cn.backgroundColor = UIColor(displayP3Red: 5/255.0, green: 50/255.0, blue: 103/255.0, alpha: 1)
        cn.layer.cornerRadius = 25.0;
        cn.addTarget(self, action: #selector(handlechangeEmail), for: .touchUpInside)
        return cn
    }()
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    @objc func handlechangeEmail() {
        print("email")
        if let window = UIApplication.shared.keyWindow {
                
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                
//            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                
            window.addSubview(blackView)
                
            window.addSubview(collectionView)
                
        let height: CGFloat = CGFloat(settings.count) * (cellHeight*1.3)
            let y = window.frame.height - 300
            let width = 250
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: CGFloat(width), height: height)
                
            blackView.frame = window.frame
            blackView.alpha = 0
                
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                self.blackView.alpha = 1
                    
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                    
            }, completion: nil)
        }
    }
    
    
    var changePass: UIButton = {
        let cp = UIButton()
        let Bcolor = UIColor.white
        cp.setTitle("Change Password", for: .normal)
        cp.titleLabel?.font =  UIFont(name: "boldSystemFont", size:15)
        cp.setTitleColor (Bcolor, for: .normal)
        cp.translatesAutoresizingMaskIntoConstraints = false
        cp.backgroundColor = UIColor(displayP3Red: 5/255.0, green: 50/255.0, blue: 103/255.0, alpha: 1)
        cp.layer.cornerRadius = 25.0;
        cp.addTarget(self, action: #selector(handlechangePassword), for: .touchUpInside)
        return cp
    }()
    
    @objc func handlechangePassword() {
        print("password")
    }
    
    //Animation when back button is pressed
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            let transition = CATransition()
            transition.duration = 0.75
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            self.navigationController?.view.layer.add(transition, forKey: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentemail = UserDefaults.standard.string(forKey: "email") ?? "no email"

        currentpassword =  UserDefaults.standard.string(forKey: "wordp") ?? "no password"
        
        currentfirstname =  UserDefaults.standard.string(forKey: "fname") ?? "no first name"
        
        currentlastname =  UserDefaults.standard.string(forKey: "lname") ?? "no last name"
        
        currentcal =  UserDefaults.standard.string(forKey: "maxcal") ?? "no max cal"
        
    
        
        print(currentpassword)
        print(currentemail)

        print(currentfirstname)
        print(currentlastname)
        print(currentcal)
        view.addSubview(backPanel)
        bpLayout()
        view.addSubview(logo)
        logoLayout()
        view.addSubview(profPic)
        profLayout()
        view.addSubview(nameLabel)
        nameLayout()
        view.addSubview(changeName)
        cNameLayout()
        view.addSubview(changePass)
        cPassLayout()
    }
    
    private func bpLayout(){
        backPanel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backPanel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        backPanel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backPanel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }
    private func logoLayout(){
        logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        logo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }
    private func profLayout(){
        profPic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profPic.centerYAnchor.constraint(equalTo: backPanel.bottomAnchor, constant: 0).isActive = true
    }
    private func nameLayout(){
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profPic.bottomAnchor, constant: 15).isActive = true
    }
    private func cNameLayout(){
        changeName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        changeName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
    private func cPassLayout(){
        changePass.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        changePass.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changePass.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changePass.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -135).isActive = true
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

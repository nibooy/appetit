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
        let Bcolor = UIColor(red: 5/255, green: 50/255, blue: 103/255, alpha: 1.0)
        cn.setTitle("Change Name", for: .normal)
        cn.titleLabel?.font =  UIFont(name: "boldSystemFont", size:15)
        cn.setTitleColor (Bcolor, for: .normal)
        cn.translatesAutoresizingMaskIntoConstraints = false
        return cn
    }()
    var changePass: UIButton = {
        let cp = UIButton()
        let Bcolor = UIColor(red: 5/255, green: 50/255, blue: 103/255, alpha: 1.0)
        cp.setTitle("Change Password", for: .normal)
        cp.titleLabel?.font =  UIFont(name: "boldSystemFont", size:15)
        cp.setTitleColor (Bcolor, for: .normal)
        cp.translatesAutoresizingMaskIntoConstraints = false
        return cp
    }()
    
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
        changeName.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        changeName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    private func cPassLayout(){
        changePass.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        changePass.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        changePass.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changePass.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
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

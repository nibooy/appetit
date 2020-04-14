//
//  AddingViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit

class AddingViewController: UIViewController {

    @IBOutlet weak var scannerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()

        // Do any additional setup after loading the view.
        scannerButton.setImage(UIImage(imageLiteralResourceName: "barcode"), for: .normal)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        //dismisses screen when tabs to another screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        
    }
    
    func setupButton(){
        scannerButton.layer.backgroundColor =  UIColor(red: 252/255, green: 244/255, blue: 236/255, alpha: 1).cgColor
        scannerButton.layer.cornerRadius = 10.0
        scannerButton.layer.borderWidth = 1.0
        scannerButton.layer.borderColor = UIColor.clear.cgColor
        scannerButton.layer.masksToBounds = true
        scannerButton.layer.shadowColor = UIColor.lightGray.cgColor
        scannerButton.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        scannerButton.layer.shadowRadius = 2.0
        scannerButton.layer.shadowOpacity = 0.7
        scannerButton.layer.masksToBounds = false
        
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

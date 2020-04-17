//
//  AddingViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

//Todos: add checks for each

//Future change measurement to be scroll wheel and make submit button pop up alert about successfully adding

import UIKit

class AddingViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var scannerButton: UIButton!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var quantityLabel: UITextField!
    
    @IBOutlet weak var measurementLabel: UITextField!
    
    @IBOutlet weak var submitButton: LoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
        scannerButton.setImage(UIImage(imageLiteralResourceName: "barcode"), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        //dismisses screen when tabs to another screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submitButton.showLoading()
    }
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "barcodeScannerVC")//need to add to storyboard this identifier
        self.definesPresentationContext = true
//        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func setupUI(){
        //Code for the button
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
        
        //Code for second panel
        formView.layer.backgroundColor =  UIColor(red: 252/255, green: 244/255, blue: 236/255, alpha: 1).cgColor
        formView.layer.cornerRadius = 10.0
        formView.layer.borderWidth = 1.0
        formView.layer.borderColor = UIColor.clear.cgColor
        formView.layer.masksToBounds = true
        formView.layer.shadowColor = UIColor.lightGray.cgColor
        formView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        formView.layer.shadowRadius = 2.0
        formView.layer.shadowOpacity = 0.7
        formView.layer.masksToBounds = false
        
        //Code for Button submit
        submitButton.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        submitButton.layer.cornerRadius = 20.0
        
    }
    
    
    // Code below for when keyboard pops up
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/1.5
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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

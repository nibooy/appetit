//
//  VirtualFridgeViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/8/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FridgeCustomCell"

class VirtualFridgeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // This is the list to hold our food objects. Backend - might need to add a field for an image to coredata.
    var fridge = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Connect to backend change the setup function
        setup(n:10)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView!.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.register(UINib.init(nibName: "AddCell", bundle: nil), forCellWithReuseIdentifier: "AddCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        //code to add button to right
        let menu = UIButton()
        menu.imageView?.contentMode = .scaleAspectFit
        menu.addTarget(self, action: #selector(menuButtonClicked), for: .touchUpInside)
        menu.setImage(UIImage(imageLiteralResourceName: "menu"), for: .normal)
        menu.widthAnchor.constraint(equalToConstant: 34.0).isActive = true
        menu.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
        let rightItem = UIBarButtonItem(customView: menu)
        
        setupLeftTitle(title: "Virtual Fridge")
        
        self.navigationItem.rightBarButtonItem  = rightItem


    }
    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

    
    // MARK: View Layout Setup
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    private let itemsPerRow: CGFloat = 2

    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fridge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if fridge[indexPath.row].name != "AddButton"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FridgeCustomCell
            cell.configureData(with: fridge[indexPath.row])
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! AddCell
            cell.delegate = self
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let pop = Popup()
        self.view.addSubview(pop)
    }
    
    //change function to however u like but make sure to keep last two lines- responsible for how we get add button
    func setup(n: Int){
        
        for _ in 0...n-1{
            let ingredient = Food(name: "Avocado", measurement: "2 Serving", image: #imageLiteral(resourceName: "Avocado"))
            self.fridge.append(ingredient)
        }
        let add = Food(name: "AddButton", measurement: "2 Serving", image: #imageLiteral(resourceName: "Avocado"))
        self.fridge.append(add)
        
        
    }
    
    func setupLeftTitle(title : String){
        let longTitleLabel = UILabel()
        longTitleLabel.text = "Virtual Fridge"
        longTitleLabel.font = .boldSystemFont(ofSize: 18)
        longTitleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= keyboardSize.height/2
               }
           }
       }

    @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
    @objc func menuButtonClicked(_ sender: UIButton) {
        
    }
}

extension VirtualFridgeViewController: AddCellDelegate {
    func didAddPressButton() {
        print("add button was pressed")
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scanningVC") as? AddingViewController {
            //viewController.newsObj = newsObj
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
     
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "scanningVC")
//        self.definesPresentationContext = true
//        controller.modalPresentationStyle = .overCurrentContext
//        self.present(controller, animated: true, completion: nil)
    }

}

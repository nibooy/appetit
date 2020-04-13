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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var menuButton: UIButton!
    
    var fridge = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(n:10)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView!.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.register(UINib.init(nibName: "AddCell", bundle: nil), forCellWithReuseIdentifier: "AddCell")
        menuButton.setImage(UIImage(imageLiteralResourceName: "menu"), for: .normal)
        self.titleLabel.text = "Virtual Fridge"
        

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    
    func setup(n: Int){
        
        for _ in 0...n-1{
            let ingredient = Food(name: "Avocado", measurement: "2 Serving", image: #imageLiteral(resourceName: "Avocado"))
            self.fridge.append(ingredient)
        }
        let add = Food(name: "AddButton", measurement: "2 Serving", image: #imageLiteral(resourceName: "Avocado"))
        self.fridge.append(add)
        
        
    }
}

extension VirtualFridgeViewController: AddCellDelegate {
    func didAddPressButton() {
        print("add button was pressed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "scanningVC")
        self.definesPresentationContext = true
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }

}

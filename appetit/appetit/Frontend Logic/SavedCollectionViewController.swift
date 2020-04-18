//
//  SavedCollectionViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SavedCollectionViewCell"

class SavedCollectionViewController: UICollectionViewController {
    var data = [RecipeInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView!.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        return data.count
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SavedCollectionViewCell
        
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "focusView")
        self.definesPresentationContext = true
        self.present(controller, animated: true, completion: nil)

    }
     
    //Process backend
    func setupData(email: String){
        let recipeController = RecipeController()
        do {
            try data = recipeController.getUserRecipe(email: email)}
        catch {
            print("failed to get recipes saved with email")
        }
        
    }
}

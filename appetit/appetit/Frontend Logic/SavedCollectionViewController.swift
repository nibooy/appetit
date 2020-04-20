//
//  SavedCollectionViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit
import SafariServices


private let reuseIdentifier = "SavedCollectionViewCell"

class SavedCollectionViewController: UICollectionViewController, SFSafariViewControllerDelegate {
    var data = [RecipeInfo]()
    var email = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView!.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        email =  UserDefaults.standard.string(forKey: "email") ?? "no email"
        print(email)
        setupData(email: email)
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        return data.count
        print(data.count)
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SavedCollectionViewCell
        let url = URL(string: data[indexPath.row].image)!
        let name = data[indexPath.row].label
        do{
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            cell.configureData(name: name, image: image ?? UIImage(imageLiteralResourceName: "Avocado"))
        }catch{
            //Set a defualt image icon later
            print("NOOOOO")
        }
        
        
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "focusView")
//        let vc = FocusRecipeViewController()
//        vc.modalPresentationStyle = .custom
//        self.definesPresentationContext = true
//        self.present(vc, animated: true, completion: nil)
        let urlString = data[indexPath.row].url

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self

            present(vc, animated: true)
        }

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
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

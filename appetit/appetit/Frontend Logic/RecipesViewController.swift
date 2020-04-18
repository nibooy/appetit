//
//  RecipesViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // CollectionView variable:
    var collectionView : UICollectionView?

    // Variables asociated to collection view:
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    var alist = ["Ulises", "Victor", "Johan", "Mom"]
    fileprivate var colors: [UIColor] = [UIColor(displayP3Red: 252.0/255.0, green: 244.0/255.0, blue: 236.0/255.0, alpha: 1), UIColor.gray, UIColor(displayP3Red: 252.0/255.0, green: 244.0/255.0, blue: 236.0/255.0, alpha: 1), UIColor.gray]
        
    struct Result: Decodable{
        let hits: [Recipe]
    }
    struct Recipe: Decodable{
        let recipe: RecipeInfo
    }
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var atGlanceInfo: UIView!
    let urlString = "https://api.edamam.com/search?"
    let apiKey = "e789925699272fcebc9ebbc5957d99b1"
    let appId = "798efc6d"
    var userEmail: String = ""
    var recipeList: [Recipe] = []
    var listOfIngredients: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCollectionView()
        self.setupLayout()
        let virtualFridgeController = VirtualFridgeController()
        do{
            
            let listOfUserIngredients:[IngredientEntity] = try virtualFridgeController.getUserIngredients(email: userEmail)
            for ingredient in listOfUserIngredients{
                listOfIngredients = listOfIngredients + " " + ingredient.ingredient
                print(listOfIngredients)
            
            }
        }catch ErrorMessage.ErrorCodes.dataSearchFailed{
            //error is that we could not read from database
        }catch{
            //unknown error
        }
        let mySession = URLSession(configuration: URLSessionConfiguration.default)
        let urlWithQueryParameters = urlString + "app_key=" + apiKey + "&app_id" + appId + "&q=" + listOfIngredients
        let url = URL(string: urlWithQueryParameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        let task = mySession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                //error message here for internet problems
                return
            }
            guard let jsonData = data else {
                //error message here for no data
                return
            }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Result.self, from: jsonData)
                self.recipeList = result.hits
                print(self.recipeList)
                DispatchQueue.main.async {
                    /*TODO: Reload table data since data structure is relaoded*/
                }
            } catch {
                //error message here while loading data
            }
        }
        task.resume()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        //dismisses screen when tabs to another screen
        self.dismiss(animated: true, completion: nil)
    }
       
    func setupLayout(){
            // This is just an utility custom class to calculate screen points
            // to the screen based in a reference view. You can ignore this and write the points manually where is required.
            
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)

        self.collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
        self.collectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            
        self.collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            
        self.collectionView?.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            
    //        self.collectionView?.heightAnchor.constraint(equalToConstant: pointEstimator.relativeHeight(multiplier: 0.6887)).isActive = true

        self.currentPage = 0
    }


    func addCollectionView(){

            // This is just an utility custom class to calculate screen points
            // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)

            // This is where the magic is done. With the flow layout the views are set to make costum movements. See https://github.com/ink-spot/UPCarouselFlowLayout for more info
        let layout = UPCarouselFlowLayout()
            // This is used for setting the cell size (size of each view in this case)
            // Here I'm writting 400 points of height and the 73.33% of the height view frame in points.
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.73333), height: 400)
            // Setting the scroll direction
        layout.scrollDirection = .horizontal

            // Collection view initialization, the collectionView must be
            // initialized with a layout object.
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            // This line if for able programmatic constrains.
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
            // CollectionView delegates and dataSource:
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
            // Registering the class for the collection view cells
        self.collectionView?.register(RecipeCell.self, forCellWithReuseIdentifier: "cellId")

            // Spacing between cells:
        let spacingLayout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 20)

        self.collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView!)

    }

        // MARK: - Card Collection Delegate & DataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! RecipeCell

        cell.customView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = alist[indexPath.row]
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        
//        let transition: CATransition = CATransition()
//        transition.duration = 0.6
//        transition.type = CATransitionType.moveIn
//        transition.subtype = CATransitionSubtype.fromTop
        
        //self.view.window?.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
        //self.navigationController?.present(viewController, animated: false, completion: nil)

    }
    
    

        // MARK: - UIScrollViewDelegate

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
            currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
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


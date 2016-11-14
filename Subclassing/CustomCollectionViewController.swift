//
//  CustomCollectionViewController.swift
//  Subclassing
//
//  Created by Dinesh Reddy.C on 11/14/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

import UIKit
import CoreData
class CustomCollectionViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet weak var collectionViewObject: UICollectionView!
    
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewObject .register(UINib (nibName: "CustomCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: MEMORY WARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath as IndexPath) as! CustomCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellInRow : Int = 2
        let padding : Int = 24
        let collectionCellWidth : CGFloat = (collectionView.frame.size.width-CGFloat(padding))/CGFloat(numberOfCellInRow)
        return CGSize(width: collectionCellWidth ,height: collectionCellWidth)
    }
}



//
//  ItemsViewController.swift
//  Utterfare Vendor
//
//  Created by Connor Meehan on 3/27/18.
//  Copyright © 2018 CBM Web Development. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ItemsControllerProtocol{
    @IBOutlet weak var itemsView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var imageUrls: Array<String> = Array(), itemNames: Array<String> = Array(), itemIDs: Array<String> = Array()
    
    func itemsDownloaded(imageURLs: Array<String>, itemNames: Array<String>, itemIDs: Array<String>) {
        self.imageUrls.append(contentsOf: imageURLs)
        self.itemNames.append(contentsOf: itemNames)
        self.itemIDs.append(contentsOf: itemIDs)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        itemsView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell: ItemCellController = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCellController
        let itemName = itemNames[indexPath.row]
        let itemImageUrl = imageUrls[indexPath.row]
        
        // Set each cell value
        itemCell.itemName.text = itemName
        itemCell.itemImage.sd_setImage(with: URL(string: itemImageUrl), placeholderImage: UIImage(named:"placeholder.png"))
        
        return itemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(self.navigationController)
        print("Pushing")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SingleItemViewController") as! SingleItemViewController
        vc.isNew = false
        vc.itemId = itemIDs[indexPath.row]
        vc.itemName = itemNames[indexPath.row]
        vc.itemDescription = "This is the description section"
        vc.itemImage = imageUrls[indexPath.row]
        print("And we pushed")
        self.navigationController?.pushViewController(vc, animated: true)
        print("Past pushing")
        print(self.navigationController)
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.itemsView.delegate = self
        self.itemsView.dataSource = self
        
        let itemsModel = ItemsModel()
        itemsModel.delegate = self
        itemsModel.downloadItems()
        
        activityIndicator.startAnimating()
        
    }
    
}

//
//  SingleItemViewController.swift
//  Utterfare Vendor
//
//  Created by Connor Meehan on 3/27/18.
//  Copyright © 2018 CBM Web Development. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class SingleItemViewController: UIViewController{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isNew: Bool = Bool()
    var itemId: String = String(), itemImage: String = String(), itemName: String = String(), itemDescription: String = String()
    
    @IBAction func uploadImageAction(){
        
    }
    
    @IBAction func saveItemAction(){
        
    }
    
    @objc func itemActionTapped(){
        let alert = UIAlertController(title: "", message: "Save or Send Item", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action) -> Void in
            print("Save")
        })
        
        let sendAction = UIAlertAction(title: "Send", style: .default, handler:{(action) -> Void in
            print("Send")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        alert.addAction(saveAction)
        self.navigationController!.present(alert, animated: true, completion: nil)
    }
    
    func getItem(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(itemActionTapped))
        
        if isNew{
            print("Not new")
        }else{
            itemNameTextField.text = itemName
            itemDescriptionTextView.text = itemDescription
            itemImageView.sd_setImage(with: URL(string: itemImage), placeholderImage: UIImage(named:"placeholder.png"))
            activityIndicator.stopAnimating()
            scrollView.isHidden = false
        }
    }
}

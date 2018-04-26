//
//  ItemsModel.swift
//  Utterfare Vendor
//
//  Created by Connor Meehan on 3/27/18.
//  Copyright © 2018 CBM Web Development. All rights reserved.
//

import Foundation

protocol ItemsControllerProtocol: class{
    func itemsDownloaded(imageURLs: Array<String>, itemNames: Array<String>, itemIDs: Array<String>)
}

class ItemsModel:NSObject{
    weak var delegate: ItemsControllerProtocol!
    let defaults = UserDefaults.standard
    func downloadItems(){
        let requestURL = URL(string: "http://localhost/utterfare/mobile/vendor/items/AddEditItems.php")
        var request = URLRequest(url: requestURL!)
        request.httpMethod = "POST"
        
        var parameters = "action=" + "getItems"
        parameters += "&offset=" + "0"
        parameters += "&DATA_TABLE=" + defaults.string(forKey: "DATA_TABLE")!.lowercased() + "_items"
        parameters += "&COMPANY_ID=" + defaults.string(forKey: "COMPANY_ID")!
        print(parameters)
        request.httpBody = parameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil{
                print("Task error: ", error)
                return
            }
            self.parseJson(data: data!)
        }
        task.resume()
    }
    
    func parseJson(data: Data){
        do{
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray
            
            if let results = jsonResponse{
                var imageUrl: Array<String> = Array()
                var itemName: Array<String> = Array()
                var itemID: Array<String> = Array()
                
                for i in 0..<(results.count){
                    let dict = results[i] as! NSDictionary
                    imageUrl.append(dict["ITEM_IMAGE"] as! String)
                    itemName.append(dict["ITEM_NAME"] as! String)
                    itemID.append(dict["ID"] as! String)
                }
                
                DispatchQueue.main.async {
                        self.delegate.itemsDownloaded(imageURLs: imageUrl, itemNames: itemName, itemIDs: itemID)
                }
                
            }
        }catch{
            print("JSON Error: ", error.localizedDescription)
        }
    }
}

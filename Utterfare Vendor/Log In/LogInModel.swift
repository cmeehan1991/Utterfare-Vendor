//
//  LogInModel.swift
//  Utterfare Vendor
//
//  Created by Connor Meehan on 3/27/18.
//  Copyright © 2018 CBM Web Development. All rights reserved.
//

import Foundation

class LogInModel{
    var valid: Bool = false
    let defaults = UserDefaults.standard
    func logIn(username: String, password: String){
        let url = URL(string: "http://localhost/utterfare/mobile/login/login.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var parameters = "username=" + username
        parameters += "&password=" + password
        parameters += "&action=" + "sign_in"
        
        request.httpBody = parameters.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil{
                print("Error is\(String(describing: error))")
                return;
            }
            let dataString = String(data: data!, encoding: .utf8)
            do{
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                if let results = jsonData{
                    print(results)
                    self.defaults.set(results["ID"] as! String, forKey: "USER_ID")
                    self.defaults.set(results["DATA_TABLE"] as! String, forKey: "DATA_TABLE")
                    self.defaults.set(results["COMPANY_ID"] as! String, forKey: "COMPANY_ID")
                    self.defaults.set(true, forKey: "IS_LOGGED_IN")
                }
            }catch{
                print("JSON Error: ", error)
            }
        }
        task.resume()
    }
}

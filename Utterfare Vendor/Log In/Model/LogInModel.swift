//
//  LogInModel.swift
//  Utterfare Vendor
//
//  Created by Connor Meehan on 3/27/18.
//  Copyright © 2018 CBM Web Development. All rights reserved.
//

import Foundation

protocol UserLogIn: class{
    func userLogIn(status: Bool, response: String, userId: String, dataTable: String, companyId: String)
}

class LogInModel: NSObject{
    weak var delegate: UserLogIn!
   
    func logIn(username: String, password: String){
        let url = URL(string: "https://www.utterfare.com/includes/mobile/vendors/Vendor_Account.php")
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
            self.parseData(data: data!)
        }
        task.resume()
    }
    
    private func parseData(data: Data){
        do{
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
            if jsonResponse.count > 0 {
                let status = jsonResponse["STATUS"] as! Bool
                let response = jsonResponse["RESPONSE"] as! String
                let userId = jsonResponse["ID"] as! String
                let dataTable = jsonResponse["DATA_TABLE"] as! String
                let companyId = jsonResponse["COMPANY_ID"] as! String
                self.doProtocol(status: status, response: response, userId: userId, dataTable: dataTable, companyId: companyId)
            }
        }catch{
            self.doProtocol(status: false, response: "JSON Error: \(error.localizedDescription)", userId: String(), dataTable: String(), companyId: String())
            print("JSON Error: \(error.localizedDescription)")
        }
    }
    
    private func doProtocol(status: Bool, response: String, userId: String, dataTable: String, companyId: String){
        DispatchQueue.main.async {
            self.delegate.userLogIn(status: status, response: response, userId: userId, dataTable: dataTable, companyId: companyId)
        }
    }
}

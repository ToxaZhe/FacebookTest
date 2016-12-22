//
//  RequestManager.swift
//  FacebookTest
//
//  Created by user on 12/15/16.
//  Copyright © 2016 PlooseTech. All rights reserved.
//

import Foundation


class RequestManager {
    
    
    static func loadRequestWithResponse(_ userEmail: String?, fbAuthenticationToken: String ) {
        let url = URL(string: "http://vps342217.ovh.net:3000/api/v1/user/signup")
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "POST"
        var postData = Data()
        postData.append("facebook_token=\(fbAuthenticationToken)".data(using: .utf8)!)
        request.httpBody = postData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                let responseString = String(data: data!, encoding: .utf8)
                print("responseString = \(responseString)")
                Parser.parseResponseWithJson(data)
            } else {
                print("\(error)")
            }
        })
        dataTask.resume()
    }
    
}

//
//  Parser.swift
//  FacebookTest
//
//  Created by user on 12/15/16.
//  Copyright © 2016 PlooseTech. All rights reserved.
//

import Foundation


class Parser {
    
    static func parseResponseWithJson(_ data: Data?) {
        do {
            guard let responseData = data else {return}
            let parsedDict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
            print("\(parsedDict)")
        } catch {
            print("\(error)")
        }

    }
    
    
    
}

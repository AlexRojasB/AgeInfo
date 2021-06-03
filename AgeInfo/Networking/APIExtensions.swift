//
//  APIExtensions.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import Foundation
import Keys

extension API {
    static func getNSUrlForNumbers(value: String, category: String) -> URLRequest {
        let keys = AgeInfoKeys()
        let headers = [
            "x-rapidapi-key": keys.rapidAPIKey,
            "x-rapidapi-host": NumberHost
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://\(NumberHost)/\(value)/\(category)?json=true")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }
    
    static func getNSUrlForZodiac(sign: String) -> URLRequest {
        let keys = AgeInfoKeys()
        let headers = [
            "x-rapidapi-key": keys.rapidAPIKey,
            "x-rapidapi-host": ZodiacHost
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://\(NumberHost)/today/long/\(sign)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 100.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }
}

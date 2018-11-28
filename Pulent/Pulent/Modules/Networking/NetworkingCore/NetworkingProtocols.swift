//
//  NetworkingProtocols.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Alamofire
import Foundation

//This lets us configure many servers if there will be more than 1
//the sample URL is: https://itunes.apple.com/search?term=in+utero&mediaType=music&limit=20

protocol Server{
    var urlComponents: URLComponents {get}
}

protocol Endpoint {
    var server : Server{get}
    var api : Api? {get}
    var method : HTTPMethod {get}
}

/*extension Endpoint: URLComponents{
    var fullUrl: String{
        var url = "\(server.baseUrl)"
        if let apiVersion = apiVersion{
            url = "\(url)/\(apiVersion.rawValue)"
        }
        url = "\(url)/\(serverObject.rawValue)"
        if let objectSorting = objectSorting{
            url = "\(url)/\(objectSorting)"
        }
        url = "\(url)?api_key=\(server.apiKey)"
        return url
    }
    var urlRequest : URLRequest?{
        if let fullUrl = URL(string: self.fullUrl){
            var urlRequest = URLRequest(url: fullUrl)
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = 10.0 //we counld define this in the endpoint protocol but for the sake of this example we will not do it
            return urlRequest
        }
        return nil
    }
}*/

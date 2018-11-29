//
//  NetworkingServers.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Foundation

//Add here all the servers that we are going to fetch... it will be just 1 in this case
//the sample URL is:
//https://itunes.apple.com/search?term=in+utero&mediaType=music&limit=20
//https://itunes.apple.com?mediaType=music&limit=20&term=Alan%20Walker
struct ServerDefault: Server {
    var urlComponents: URLComponents {
        get{
            var components = URLComponents()
            components.scheme = "https"
            components.host = "itunes.apple.com"
            return components
        }
    }
}

//
//  SongsEnpoints.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Alamofire
import Foundation

//we can add multiple endpoints, this way we can just look at this file and see the main structure of each endpoint :)

struct SearchSongEndpoint: Endpoint{
    var server: Server = ServerDefault()
    var api: Api? = .search
    var method: HTTPMethod = .get
}

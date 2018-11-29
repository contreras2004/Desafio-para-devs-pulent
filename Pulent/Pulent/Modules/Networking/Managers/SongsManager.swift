//
//  SongsManager.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Foundation

//for the sake of this exercise we will just create a singletone to manage the songs coming from the server.
class SongsManager{
    
    static let shared = SongsManager()
    var songs = [Song]()
    
    func fetchSongs(searchSongRequestModel: SearchSongRequestModel, handler: (([Song]?, Error?) -> Void)? = nil) {
        var endpoint = SearchSongEndpoint()
        endpoint.urlParams = searchSongRequestModel
        
        NetworkingManager().request(endpoint: endpoint) { (searchResponseModel: SearchResponseModel?, error: Error?) in
            if let songs = searchResponseModel?.results{
                self.songs = songs
            }
            
            handler!(searchResponseModel?.results, error)
        }
    }
}

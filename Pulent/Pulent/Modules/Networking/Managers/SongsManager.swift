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
    
    func fetchSongs(searchSongRequestModel: SearchSongRequestModel, handler: (([Song]?, NSError?) -> Void)? = nil) {
        var endpoint = SearchSongEndpoint()
        endpoint.urlParams = searchSongRequestModel
        
        NetworkingManager().request(endpoint: endpoint) { (searchResponseModel: SearchResponseModel?, error: NSError?) in
            
            //PLEASE READ
            
            //I was going to add a local storage system here ..... but I dont think saving the results of a SearchTerm will be very efficient or usefull ... the way that this would be done is just by adding a key to userDefaults with the name of the request to save the Data that comes from the server, that way we could retrieve the data from userDefaults by the key defined by the URL that was fetched when an error from AlamoFire is returned by the Networking manager.
            
            // * Disclaimer: I know that storing data into userDefaults is not eficient NOR a correct thing to do, in other cases this would be done by storing the data into CoreData, we could use a custom SQLite database, we could store the data into a Json file, or we could use other types of storage far more eficient than userDefaults.
            
            if let songs = searchResponseModel?.results{
                self.songs = songs
            }
            
            handler!(searchResponseModel?.results, error)
        }
    }
}

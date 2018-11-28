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
    
    func fetchSongs(){
        
    }
}

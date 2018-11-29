//
//  SearchSongRequestModel.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Foundation

struct SearchSongRequestModel: Codable{
    
    enum MediaType: String, Codable{
        case music
    }
    
    var term : String?          = nil
    var mediaType : MediaType?  = .music
    var limit : Int?            = 20
    var offset : Int            = 0 //this was tricky..... the api has no documentation on the offset attribute...... thanks to https://stackoverflow.com/a/46707491/1489992
}

//
//  SongModelTests.swift
//  PulentTests
//
//  Created by Matías Contreras Selman on 11/29/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import XCTest
@testable import Pulent

class SongModelTests: XCTestCase {
    
    func testNetworkingManager(){
        let term = "Alan Walker"
        let searchSongRequestModel = SearchSongRequestModel(term: term, mediaType: .music, limit: 20, offset: 0)
        var endpoint = SearchSongEndpoint()
        endpoint.urlParams = searchSongRequestModel
        
        NetworkingManager().request(endpoint: endpoint) { (searchResponseModel: SearchResponseModel?, error: NSError?) in
            XCTAssertTrue(searchResponseModel?.results?.count ?? 0 > 0)
        }
    }
    
    func testSongsManager(){
        let term = "Alan Walker"
        let searchSongRequestModel = SearchSongRequestModel(term: term, mediaType: .music, limit: 20, offset: 0)
        var endpoint = SearchSongEndpoint()
        endpoint.urlParams = searchSongRequestModel
        
        SongsManager.shared.fetchSongs(searchSongRequestModel: searchSongRequestModel) { (songs, error) in
            XCTAssertTrue(songs?.count ?? 0 > 0)
        }
    }

}

//
//  Song.swift
//  Pulent
//
//  Created by Matías Contreras on 11/28/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import Foundation

struct SearchResponseModel: CodableWithDateFormat{
    let resultCount: Int?
    let results: [Song]?
}

struct Song: Codable, Equatable{
    
    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.trackId == rhs.trackId && lhs.artistId == rhs.artistId
    }
    
    var wrapperType: String? = nil
    var kind: String?  = nil
    var artistId: Int?  = nil
    var collectionId: Int?  = nil
    var trackId: Int? = nil
    var artistName: String? = nil
    var collectionName: String? = nil
    var trackName: String? = nil
    var collectionCensoredName: String? = nil
    var trackCensoredName: String? = nil
    var artistViewUrl: URL? = nil
    var collectionViewUrl: URL? = nil
    var trackViewUrl: URL? = nil
    var previewUrl: URL? = nil
    var artworkUrl30: URL? = nil
    var artworkUrl60: URL? = nil
    var artworkUrl100: URL? = nil
    var collectionPrice: Double? = nil
    var trackPrice: Double? = nil
    var releaseDate: Date?  = nil//datefimeFormat: 2015-12-03T08:00:00Z" -> "yyyy-MM-dd'T'HH:mm:ssZ"
    var collectionExplicitness: String? = nil
    var trackExplicitness: String? = nil
    var discCount: Int? = nil
    var discNumber: Int? = nil
    var trackCount: Int? = nil
    var trackNumber: Int? = nil
    var trackTimeMillis: Int? = nil
    var country: String? = nil
    var currency: String? = nil
    var primaryGenreName: String? = nil
    var isStreamable: Bool? = nil
}

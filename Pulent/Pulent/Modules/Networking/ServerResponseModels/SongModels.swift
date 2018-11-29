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
    
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: URL? //https://itunes.apple.com/us/artist/alan-walker/1062085272?uo=4",
    let collectionViewUrl: URL? //https://itunes.apple.com/us/album/faded/1196294554?i=1196294581&uo=4",
    let trackViewUrl: URL? // https://itunes.apple.com/us/album/faded/1196294554?i=1196294581&uo=4",
    let previewUrl: URL? // https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview111/v4/90/b5/01/90b501ac-78bd-a7c1-6726-8f82fe0c2b4e/mzaf_3304804784910350487.plus.aac.p.m4a",
    let artworkUrl30: URL? // https://is4-ssl.mzstatic.com/image/thumb/Music122/v4/b8/ab/93/b8ab934a-810e-933a-135a-5901bfd94a73/source/30x30bb.jpg",
    let artworkUrl60: URL? // https://is4-ssl.mzstatic.com/image/thumb/Music122/v4/b8/ab/93/b8ab934a-810e-933a-135a-5901bfd94a73/source/60x60bb.jpg",
    let artworkUrl100: URL? // https://is4-ssl.mzstatic.com/image/thumb/Music122/v4/b8/ab/93/b8ab934a-810e-933a-135a-5901bfd94a73/source/100x100bb.jpg",
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: Date?//2015-12-03T08:00:00Z",  "yyyy-MM-dd'T'HH:mm:ssZ"
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
}

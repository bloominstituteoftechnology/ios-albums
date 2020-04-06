//
//  Album.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

struct CoverArt: Decodable {
    let url: String
}

struct Album: Decodable {
    
    /// This is about conforming to the data that we are reading in. So case name doesn't have to match fullname
    // TODO: ? Why String?
    enum AlbumKeys: String, CodingKey {
        case id
        case album = "name"
        case artist
        case genres
        case coverArt
        case songs
    }

    var id: UUID         // 5E58FA0F-7DBD-4F1D-956F-89756CF1EB22
    var album: String    // Weezer (The Blue Album)
    var artist: String   // Weezer
    var genres: String   // Alternative
    var coverArt: String // https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png
    var songs: [Song]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        album = try container.decode(String.self, forKey: .album)
        artist = try container.decode(String.self, forKey: .artist)

        let coverArtArray = try container.decode([CoverArt].self, forKey: .coverArt)
        coverArt = [String](coverArtArray.map { $0.url }).joined(separator:", ")
        print("\(coverArt)")

        // URL is codable, so we can decode an array of them
        let genresArray = try container.decode([String].self, forKey: .genres)
        genres = genresArray.joined(separator:", ")
        print("\(genresArray)")

        songs = try container.decode([Song].self, forKey: .songs)
    }
}

struct SongTitle: Decodable {
    let title: String
}

struct SongDuration: Decodable {
    let duration: String
}

struct Song: Decodable {
    enum SongKeys: String, CodingKey {
        case id
        case title = "name"
        case duration
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)

        let songTitle = try container.decode(SongTitle.self, forKey: .title)
        title = songTitle.title

        let songDuration = try container.decode(SongDuration.self, forKey: .duration)
        duration = songDuration.duration
    }

    var id: UUID
    var title: String
    var duration: String
}

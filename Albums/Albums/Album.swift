//
//  Album.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    var coverArt: [URL]
    var genres: [String]
    let id, name: String
    var songs: [Song]

    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs

        enum CoverArtKeys: String, CodingKey {
            case url
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)

        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtArray: [URL] = []
        while coverArtContainer.isAtEnd == false {
            let coverArtURLsContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)

            let coverArtString = try coverArtURLsContainer.decode(String.self, forKey: .url)

            if let coverArtURL = URL(string: coverArtString) {
                coverArtArray.append(coverArtURL)
            }
        }
        coverArt = coverArtArray
        genres = try container.decode([String].self, forKey: .genres)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
    }

    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)

        try container.encode(artist, forKey: .artist)

        var coverArtContainer = container.nestedContainer(keyedBy: , forKey: .coverArt)

        try container.encode(genres, forKey: .genres)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(<#T##value: Bool##Bool#>, forKey: <#T##Album.AlbumKeys#>)

    }

}
struct Song: Codable {
    let duration: String
    let id: String
    let name: String

    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name

        enum DurationKeys: String, CodingKey {
            case duration
        }

        enum NameKeys: String, CodingKey {
            case title
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)

        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)

        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)

        id = try container.decode(String.self, forKey: .id)

    }
}

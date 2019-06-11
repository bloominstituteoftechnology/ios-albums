//
//  Album.swift
//  Albums
//
//  Created by Jonathan Ferrer on 6/10/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id, name: String
    var songs: [Song]?

    init(artist: String, coverArt: [URL], genres: [String], id: String = UUID().uuidString, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }

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

        var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)

        // Cycle through them encode them into an object in the array
        for coverArtURL in coverArt {
            var coverArtContainer = coverArtsContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtContainer.encode(coverArtURL.absoluteString, forKey: .url)
        }

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(songs, forKey: .songs)

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

    init(duration: String, id: String = UUID().uuidString, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        try container.encode(id, forKey: .id)
        var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
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

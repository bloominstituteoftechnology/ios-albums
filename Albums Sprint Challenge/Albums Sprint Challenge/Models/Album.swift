//
//  Album.swift
//  Albums Sprint Challenge
//
//  Created by Elizabeth Wingate on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Album: Decodable, Encodable {
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]

enum CodingKeys: String, CodingKey {

    case artist
    case coverArt
    case genres
    case id
    case name
    case songs

    enum AllCoverArt: String, CodingKey {
        case url
    }
  }
    // MARK: - Codable
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let artist = try container.decode(String.self, forKey: .artist)
            let id = try container.decode(String.self, forKey: .id)
            let name = try container.decode(String.self, forKey: .name)

            var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)

            var coverArtsContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
            var coverArtURLStrings: [String] = []

            while !coverArtsContainer.isAtEnd {
                let coverArtContainer = try coverArtsContainer.nestedContainer(keyedBy: CodingKeys.AllCoverArt.self)
                let coverArtURLString = try coverArtContainer.decode(String.self, forKey: .url)
                coverArtURLStrings.append(coverArtURLString)
            }

            let coverArtURLs = coverArtURLStrings.compactMap() { URL(string: $0) }

            let genres = try container.decode([String].self, forKey: .genres)

            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            var songs: [Song] = []

            while !songsContainer.isAtEnd {
                let song = try songsContainer.decode(Song.self)
                songs.append(song)
            }

            // Set all the properties
            self.artist = artist
            self.name = name
            self.id = id
            self.coverArt = coverArtURLs
            self.genres = genres
            self.songs = songs
        }
    
    // MARK: - Encodable
         func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(artist, forKey: .artist)

            var coverArtsContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
            
            for coverArtURL in coverArt {
                var coverArtContainer = coverArtsContainer.nestedContainer(keyedBy: CodingKeys.AllCoverArt.self)
                try coverArtContainer.encode(coverArtURL.absoluteString, forKey: .url)
            }

            try container.encode(genres, forKey: .genres)

            try container.encode(id, forKey: .id)

            try container.encode(name, forKey: .name)

            try container.encode(songs, forKey: .songs)

        }

        init(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Song]) {
            self.artist = artist
            self.coverArt = coverArt
            self.genres = genres
            self.id = id
            self.name = name
            self.songs = songs
        }
}

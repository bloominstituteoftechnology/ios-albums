//
//  Album.swift
//  iOS Albums
//
//  Created by Dillon P on 10/30/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation

struct Song: Decodable {
    let name: String
    let duration: String
    let id: UUID
    
    enum SongKeys: String, CodingKey {
        case name
        case duration
        case id
    }
    
    enum SongNameKeys: String, CodingKey {
        case title
    }
    
    enum SongDurationKeys: String, CodingKey {
        case duration
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        let uuid = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: uuid)!
        
        let nameContainer = try container.nestedContainer(keyedBy: SongNameKeys.self, forKey: .name)
        self.name = try nameContainer.decode(String.self, forKey: .title)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongDurationKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .duration)
    }
    
    
}

struct Album: Decodable {
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
    }
    
    enum CoverArtCodingKeys: String, CodingKey {
        case url
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        
        // Get artist name
        self.artist = try container.decode(String.self, forKey: .artist)
        
        // Get cover art URL
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverArt: [URL] = []
        
        while !coverArtContainer.isAtEnd {
            let coverArtUrlContainer = try coverArtContainer.nestedContainer(keyedBy: CoverArtCodingKeys.self)
            let coverArtUrl = try coverArtUrlContainer.decode(URL.self, forKey: .url)
            coverArt.append(coverArtUrl)
        }
        
        self.coverArt = coverArt
        
        // Get genres
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        
        var genres: [String] = []
        
        while !genresContainer.isAtEnd {
            let genre = try genresContainer.decode(String.self)
            genres.append(genre)
        }
        
        self.genres = genres
        
        // Get ID
        self.id = try container.decode(String.self, forKey: .id)
        
        // Get name
        self.name = try container.decode(String.self, forKey: .name)
        
        // Get Songs
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        var songs: [Song] = []
        
        while !songsContainer.isAtEnd {
            let song = try songsContainer.decode(Song.self)
            songs.append(song)
        }
        
        self.songs = songs
    }
    
}

//
//  Album.swift
//  Albums
//
//  Created by Ciara Beitel on 9/30/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

struct Album: Decodable {
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum GenreContentKeys: String, CodingKey {
            case genre
            
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        artist = try container.decode(String.self, forKey: .artist)
        
        let coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        coverArt = try container.decode([URL].self, forKey: .coverArt)
        
        var genresNames: [String] = []
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        while !genresContainer.isAtEnd {
            let genreContentContainer = try genresContainer.nestedContainer(keyedBy: AlbumKeys.GenreContentKeys.self)
            let genreName = try genreContentContainer.decode(String.self, forKey: .genre)
            genresNames.append(genreName)
        }
        genres = genresNames
        
        
        id = try container.decode(String.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        songs = try songsContainer.decode([Song].self)
        
    }
        
}
    

struct Song: Decodable {
    var duration: String
    var id: String
    var name: String
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        duration = try container.decode(String.self, forKey: .duration)
    }
}

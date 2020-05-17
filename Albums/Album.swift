//
//  Album.swift
//  Albums
//
//  Created by Kenneth Jones on 5/15/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let id: String
    let name: String
    let artist: String
    let coverArt: [URL]
    let genres: [String]
    let songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist, coverArt, genres, id, name, songs
        
        enum ArtKey: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var genreNames: [String] = []
        while genresContainer.isAtEnd == false {
            let genreName = try genresContainer.decode(String.self)
            genreNames.append(genreName)
        }
        genres = genreNames
        
        var artContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var artwork: [URL] = []
        while artContainer.isAtEnd == false {
            let artURLContainer = try artContainer.nestedContainer(keyedBy: AlbumKeys.ArtKey.self)
            let artURL = try artURLContainer.decode(URL.self, forKey: .url)
            artwork.append(artURL)
        }
        coverArt = artwork
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songNames: [Song] = []
        while songsContainer.isAtEnd == false {
            let songName = try songsContainer.decode(Song.self)
            songNames.append(songName)
        }
        songs = songNames
    }
}

struct Song: Decodable {
    let id: String
    let name: String
    let duration: String
    
    enum SongKeys: String, CodingKey {
        case duration, id, name
        
        enum DurationKey: String, CodingKey {
            case duration
        }
        
        enum NameKey: String, CodingKey {
            case title
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
}

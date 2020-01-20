//
//  Album.swift
//  Albums
//
//  Created by Craig Swanson on 1/15/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import Foundation
import UIKit

struct Album {
    var artist: String
    var coverArt: [URL]
    var genre: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumKeys: String, CodingKey {
        case artist
        case id
        case name
        case coverArt
        case genres
        case songs
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
        enum SongsKeys: String, CodingKey {
            case duration
            case id
            case name
            
            enum durationKeys: String, CodingKey {
                case duration
            }
            
            enum nameKeys: String, CodingKey {
                case title
            }
        }
        
    }
}

struct Song {
    var duration: String
    var id: String
    var name: String
}


// MARK: - Codable extensions
extension Album: Codable {
    
// MARK: - Album decode
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var decodedCoverArt = [URL]()
        while !coverArtContainer.isAtEnd {
            
            let coverArtKeyedContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            
            let coverArtString = try coverArtKeyedContainer.decode(URL.self, forKey: AlbumKeys.CoverArtKeys.url)
            decodedCoverArt.append(coverArtString)
        }
        coverArt = decodedCoverArt
        
        
        
        var genreContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var decodedGenre = [String]()
        while !genreContainer.isAtEnd {
            
            let genreName = try genreContainer.decode(String.self)
            decodedGenre.append(genreName)
        }
        genre = decodedGenre
        
        var songsUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        var songList: [Song] = []
        while !songsUnkeyedContainer.isAtEnd {
            let songKeyedContainer = try songsUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.SongsKeys.self)
            
            let durationKeyedContainer = try songKeyedContainer.nestedContainer(keyedBy: AlbumKeys.SongsKeys.durationKeys.self, forKey: .duration)
            let songDuration = try durationKeyedContainer.decode(String.self, forKey: .duration)
            
            let songID = try songKeyedContainer.decode(String.self, forKey: .id)
            
            let songNameKeyedContainer = try songKeyedContainer.nestedContainer(keyedBy: AlbumKeys.SongsKeys.nameKeys.self, forKey: .name)
            let songName = try songNameKeyedContainer.decode(String.self, forKey: .title)
            let newSong = Song(duration: songDuration, id: songID, name: songName)
            songList.append(newSong)
        }
        songs = songList
    }
    
    // MARK: - Album encode
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        var coverArtContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for coverArtURL in coverArt {
            var coverArtStringContainer = coverArtContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtStringContainer.encode(coverArtURL.absoluteString, forKey: .url)
        }
        
        var genreContainer = container.nestedUnkeyedContainer(forKey: .genres)
        for genre in genre {
            try genreContainer.encode(genre)
        }
        
        var songUnkeyedContainer = container.nestedUnkeyedContainer(forKey: .songs)
        for oneSong in songs {
            var songKeyedContainer = songUnkeyedContainer.nestedContainer(keyedBy: AlbumKeys.SongsKeys.self)
            try songKeyedContainer.encode(oneSong.id, forKey: .id)
            var durationKeyedContainer = songKeyedContainer.nestedContainer(keyedBy: AlbumKeys.SongsKeys.durationKeys.self, forKey: .duration)
            try durationKeyedContainer.encode(oneSong.duration, forKey: .duration)
            var titleKeyedContainer = songKeyedContainer.nestedContainer(keyedBy: AlbumKeys.SongsKeys.nameKeys.self, forKey: .name)
            try titleKeyedContainer.encode(oneSong.name, forKey: .title)
        }
        
        
    }
    
}

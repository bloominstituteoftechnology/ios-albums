//
//  Album.swift
//  Albums
//
//  Created by Marissa Gonzales on 5/7/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

struct Album: Decodable, Encodable {
    var artist: String
    var coverArtURLs: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Song]
    
    enum AlbumCodingKeys: String, CodingKey {
        case artist, coverArt, genres, id, name, songs
        
        enum CoverArt: String, CodingKey {
            case url
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        let artist = try container.decode(String.self, forKey: .coverArt)
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLStrings: [String] = []
        
        while !coverArtContainer.isAtEnd {
            let allCoverArtsContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumCodingKeys.CoverArt.self)
            let coverArtURLStr = try allCoverArtsContainer.decode(String.self, forKey: .url)
             coverArtURLStrings.append(coverArtURLStr)
        }
        
        let coverArt = coverArtURLStrings.compactMap() { URL(string: $0)}
        
        let genres = try container.decode([String].self, forKey: .genres)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let songs = try container.decode([Song].self, forKey: .songs)
        var songsArray: [Song] = []
        var songContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        while !songContainer.isAtEnd {
            let song = try songContainer.decode(Song.self)
            songsArray.append(song)
        }
  
        self.artist = artist
        self.coverArtURLs = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    init(artist: String, coverArtURLs: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        self.artist = artist
        self.coverArtURLs = coverArtURLs
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
    struct Song: Decodable, Encodable {
        var duration: String
        var id: String
        var title: String
        
        enum SongCodingKeys: String, CodingKey {
            case duration, id, name
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: SongCodingKeys.self)
            
            let durationDict = try container.decode([String: String].self, forKey: .duration)
            duration = durationDict["duration"] ?? ""
            
            id = try container.decode(String.self, forKey: .id)
            
            let nameContainer = try container.decode([String: String].self, forKey: .name)
            title = nameContainer["title"] ?? ""
            
            
        }
        init(duration: String, id: String, title: String) {
            self.duration = duration
            self.id = id
            self.title = title
        }
    }


}



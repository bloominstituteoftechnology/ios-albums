//
//  Album.swift
//  Albums
//
//  Created by scott harris on 3/9/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        case id
        case artist
        case name
        case songs
        case genres
        case coverArt
        
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
    }
    
    var id: UUID
    var name: String
    var genres: [String]
    var artist: String
    var coverArtURLs: [URL]
    var songs: [Song]
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        artist = try container.decode(String.self, forKey: .artist)
        name = try container.decode(String.self, forKey: .name)
        
        var coverArtContainerArray = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtUrls: [URL] = []
        while !coverArtContainerArray.isAtEnd {
            let coverArtContainer = try coverArtContainerArray.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let coverArtUrl = try coverArtContainer.decode(URL.self, forKey: .url)
            coverArtUrls.append(coverArtUrl)
            
        }
        
        coverArtURLs = coverArtUrls
        genres = try container.decode([String].self, forKey: .genres)
        songs = try container.decode([Song].self, forKey: .songs)
        
    }
    
    
}

struct Song: Decodable {
    
    enum SongKeys: String, CodingKey {
        case id
        case duration
        case name
       
        enum DurationDescptionKeys: String, CodingKey {
            case duration
        }
        
        enum NameDescriptionKeys: String, CodingKey {
            case title
        }
        
        
        
    }
    
    var duration: String
    var id: UUID
    var title: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationDescptionKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.self, forKey: .name)
        title = try nameContainer.decode(String.self, forKey: .title)
        
    }

}

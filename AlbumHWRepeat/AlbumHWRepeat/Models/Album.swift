//
//  Album.swift
//  AlbumHWRepeat
//
//  Created by Michael Flowers on 6/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artist: String
    let coverArt: [URL] //convert from string to url
    let genres: [String]
    let id: UUID //convert from string to uuid
    let name: String
    let songs: [Song]
    
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

        // we want to decode this into an uuid
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        songs = try container.decode([Song].self, forKey: .songs)
        genres = try container.decode([String].self, forKey: .genres)

        //getting inside of the array
        var coverArtArrayContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)


        //create a place holder array
        var coverArtStringArray: [String] = []
        while coverArtArrayContainer.isAtEnd == false {

            //now that we are inside of the array we are confronted by a blanked named dixtionary
            let coverArtDictionaryContainer = try coverArtArrayContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)

            //now that we are inside of the blanked named dictionary we can decode
            let coverArtString = try coverArtDictionaryContainer.decode(String.self, forKey: .url)
            coverArtStringArray.append(coverArtString)
        }
        coverArt = coverArtStringArray.compactMap { URL(string: $0) }
    }
    
    func encode(with encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        try container.encode(artist, forKey: .artist)
        try container.encode(name, forKey: .name)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        //convert url back into strings
        //create a container for the array
        var coverArtArrayContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        //loop through the array that we have
        for art in coverArt {
            //now that we are inside the array we have to create a container for the un-named dictionary
            var coverArtDictionaryContainer = coverArtArrayContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            
            //now that we are inside the array and inside the dictionary we can go ahead and try to encode and covert url back into string
            try coverArtDictionaryContainer.encode(art, forKey: .url)
        }
    }
    
    init(artist: String, name: String, genres: [String], coverArt: [URL], songs: [Song], id: UUID = UUID()){
        self.artist = artist
        self.name = name
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
        self.id = id
    }
}

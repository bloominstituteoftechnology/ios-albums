//
//  Album.swift
//  Albums
//
//  Created by Mark Gerrior on 4/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

struct CoverArt: Equatable, Codable {
    let url: String
}

// TODO: ? Class or Struct. Wnat about follow on objects?
class Album: Codable {
    
    /// This is about conforming to the data that we are reading in. So case name doesn't have to match fullname
    // TODO: ? Why String?
    enum AlbumKeys: String, CodingKey {
        case id
        case album = "name"
        case artist
        case genres
        case coverArt
        case songs
    }

    var id: UUID         // 5E58FA0F-7DBD-4F1D-956F-89756CF1EB22
    var album: String    // Weezer (The Blue Album)
    var artist: String   // Weezer
    var genres: String   // Alternative
    var coverArt: String // https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png
    var songs: [Song]

    init(album: String, artist: String, genres: String, coverArt: String, songs: [Song] = []) {

        self.id = UUID()

        self.album = album
        self.artist = artist
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        album = try container.decode(String.self, forKey: .album)
        artist = try container.decode(String.self, forKey: .artist)

        let coverArtArray = try container.decode([CoverArt].self, forKey: .coverArt)
        coverArt = [String](coverArtArray.map { $0.url }).joined(separator:", ")
        print("\(coverArt)")

        // URL is codable, so we can decode an array of them
        let genresArray = try container.decode([String].self, forKey: .genres)
        genres = genresArray.joined(separator:", ")
        print("\(genresArray)")

        do {
            songs = try container.decode([Song].self, forKey: .songs)
        } catch {
            songs = []
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(album, forKey: .album)
        try container.encode(artist, forKey: .artist)
        
        let genresArray = genres.components(separatedBy: ",").map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        try container.encode(genresArray, forKey: .genres)

        let coverArtArray = coverArt.components(separatedBy: ",").compactMap{ CoverArt(url: $0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        try container.encode(coverArtArray, forKey: .coverArt)

        try container.encode(songs, forKey: .songs)
    }
}

struct SongTitle: Equatable, Codable {
    let title: String
}

struct SongDuration: Equatable, Codable {
    let duration: String
}

struct Song: Equatable, Codable {
    enum SongKeys: String, CodingKey {
        case id
        case title = "name"
        case duration
    }

    var id: UUID
    var title: String
    var duration: String
    
    init(title: String, duration: String) {
        
        self.id = UUID()
        self.title = title
        self.duration = duration
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)

        let songTitle = try container.decode(SongTitle.self, forKey: .title)
        title = songTitle.title

        let songDuration = try container.decode(SongDuration.self, forKey: .duration)
        duration = songDuration.duration
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SongKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)

        let songTitle = SongTitle(title: title)
        try container.encode(songTitle, forKey: .title)
        
        let songDuration = SongDuration(duration: duration)
        try container.encode(songDuration, forKey: .duration)
    }
}


struct AlbumRepresentation: Equatable, Codable {
    
    let id: UUID
    let name: String
    let artist: String
    let genres: [String]
    let coverArt: [CoverArt]
    let songs: [Song]
}


//
//  Album.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Album {
    
    var albumID: String
    var name: String
    var artist: String
    var genres: [String]
    var coverArt: [String]
    var songs: [Song]
    
    init(albumID: String = UUID().uuidString, name: String, artist: String,
         genres: [String], coverArt: [String], songs: [Song]) {
        
        self.albumID = albumID
        self.name = name
        self.artist = artist
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songs
    }
}

struct Song {
    var songID: String
    var songTitle: String
    var songDuration: UnitDuration
    
    init(songID: String = UUID().uuidString, songTitle: String, songDuration: UnitDuration) {
        self.songID = songID
        self.songTitle = songTitle
        self.songDuration = songDuration
    }
}

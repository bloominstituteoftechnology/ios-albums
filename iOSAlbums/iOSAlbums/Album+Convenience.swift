//
//  Album+Convenience.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/26/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

extension Album {
    
    init(artist: String, coverArt: [URL] = [], genres: [String] = [], id: UUID, name: String, songs: [Song] ) {
    
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
        
    }
    
}

extension Song {
    
    init(name: String, duration: String, id: UUID){
        
        self.name = name
        self.duration = duration
        self.id = id
    }
}

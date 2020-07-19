
import Foundation

extension Album {
    
    init(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Songs]) {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
    }
    
}

extension Songs {
    
    init(duration: String, id: String, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
}

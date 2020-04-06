//
//  AlbumController.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation


class AlbumController {
    
    var albums = [Album]()
    
    func createAlbum(artist: String, coverArtURLs: [URL], genres: [String], id: String, name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArtURLs: coverArtURLs, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        firebaseClient.putAlbum(album) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func createSong(duration: String, id: String, title: String) -> Song {
        Song(duration: duration, id: id, title: title)
    }
    
    private let firebaseClient = FirebaseClient()
    
    
    static func testDecodingExampleAlbum() {
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let album = try! JSONDecoder().decode(Album.self, from: data)
        
        print(album)
        print("\n\n\n")
        testEncodingExampleAlbum(album)
    }
    
    static func testEncodingExampleAlbum(_ album: Album) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(album)
        let string = String(data: data, encoding: .utf8)!
        
        print(string)
    }
}

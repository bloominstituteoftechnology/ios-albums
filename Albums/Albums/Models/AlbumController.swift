//
//  AlbumController.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation


class AlbumController {
    
    // MARK: - CRUD
    
    private(set) var albums = [Album]()
    
    func getAlbums(completion: @escaping (Bool) -> Void) {
        firebaseClient.getAlbums { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let networkError):
                    print(networkError)
                    completion(false)
                case .success(let albums):
                    self.albums = albums
                    completion(true)
                }
            }
        }
    }
    
    func createAlbum(artist: String, coverArtURLs: [String], genres: [String], name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArtURLs: coverArtURLs, genres: genres, id: UUID().uuidString, name: name, songs: songs)
        albums.append(album)
        
        firebaseClient.putAlbum(album) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func update(_ album: Album, artist: String, coverArtURLs: [String], genres: [String], name: String, songs: [Song]) {
        guard let albumIndex = albums.firstIndex(of: album) else {
            createAlbum(artist: artist, coverArtURLs: coverArtURLs, genres: genres, name: name, songs: songs)
            return
        }
        let updatedAlbum = Album(artist: artist, coverArtURLs: coverArtURLs, genres: genres, id: album.id, name: name, songs: songs)
        albums[albumIndex] = updatedAlbum
        
        firebaseClient.putAlbum(updatedAlbum) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func deleteAlbum(at index: Int) {
        let album = albums.remove(at: index)
        
        firebaseClient.deleteAlbum(album) { error in
            if let error = error {
                print(error)
            }
        }
        
    }
    
    func createSong(title: String, duration: String) -> Song {
        Song(duration: duration, id: UUID().uuidString, title: title)
    }
    
    // MARK: - Private
    
    private let firebaseClient = FirebaseClient()

}

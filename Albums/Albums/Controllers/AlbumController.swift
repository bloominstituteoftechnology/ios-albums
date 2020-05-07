//
//  AlbumController.swift
//  Albums
//
//  Created by Brian Rouse on 5/7/20.
//  Copyright © 2020 Brian Rouse. All rights reserved.
//

import Foundation

class AlbumController {
    
    var albums: [Album] = []
    
    func loadAlbums(completion: @escaping (Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return }
        let fileURL = URL(fileURLWithPath: path)
        
        URLSession.shared.dataTask(with: fileURL) { (data, _, error) in
            if let error = error {
                NSLog("Error loading albums:\(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned: No decode")
                if let error = error {
                    completion(error)
                }
                return
            }
            
            do{
                let albums = try [JSONDecoder().decode(Album.self, from: data)]
                self.albums = albums
            } catch {
                NSLog("Error decoding albums:\(error)")
                
            }
        }.resume()
    }
    
    func postAlbum(album: Album) {
        guard let path = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return }
        let fileURL = URL(fileURLWithPath: path)
        
        var request = URLRequest(url: fileURL)
        
        do{
            let albumData = try JSONEncoder().encode(album)
            request.httpBody = albumData
        } catch {
            NSLog("Error creating Album:\(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
        }.resume()
    }
    
}

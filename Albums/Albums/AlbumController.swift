//
//  AlbumController.swift
//  Albums
//
//  Created by Nelson Gonzalez on 2/18/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class AlbumController {
    
    // Data source for the application
    var albums: [Album] = []
  
    private let baseURL = URL(string: "https://nelson-ios-journal.firebaseio.com/")!
    
    func getAlbums(completion: @escaping(Error?) -> Void){
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching albums: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from the data task")
                completion(NSError())
                return
            }
            
            DispatchQueue.main.async {
                
                do {
                    self.albums = try JSONDecoder().decode([String: Album].self, from: data).map({$0.value})
                    
                } catch {
                    NSLog("Error decoding album: \(error)")
                }
            }
            }.resume()
    }
    
    
   
    func testDecodingExampleAlbum() {
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("URL not functioning")
            return
        }
        
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            var album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            
            print(album)
            print("SUCCESS!")
        } catch {
            print("Error retrieving data: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("URL not functioning")
            return
        }
        
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            var album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print(album)
            let encodedAlbum = try JSONEncoder().encode(album)
            print(String(data: encodedAlbum, encoding: .utf8)!)
            print("SUCCESS!")
        } catch {
            print("Error retrieving data: \(error)")
        }
        
        
        
    }
    
    
}

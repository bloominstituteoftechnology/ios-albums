//
//  AlbumController.swift
//  Albums
//
//  Created by Lambda_School_Loaner_218 on 1/13/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class AlbumController {
    
    var albums = [Album]()
    let baseURL = URL(string: "https://myalbums-836c4.firebaseio.com/")
    
    func testDecodingExampleAlbum() {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json"), let data = try? Data(contentsOf: url) else { return }
        
        let decoder = JSONDecoder()
        do {
            let album = try decoder.decode(Album.self, from: data)
            print(album)
        } catch let decodeError {
            print(decodeError)
        }
    }
    
    func getAlbums(completion: @escaping (Error?) -> ()) {
        guard let url = baseURL else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(NSError(domain: "AlbumError", code: response.statusCode, userInfo: nil))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(NSError(domain: "AlbumError", code: 0, userInfo: nil))
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let albumsData = try decoder.decode([String: Album].self, from: data)
                self.albums = Array(albumsData.values)
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch let decodeError {
                DispatchQueue.main.async {
                    completion(decodeError)
                }
                return
            }
        }.resume()
    }
    
    func put(album: Album, completion: @escaping (Error?) -> Void) {
        guard let requestURL = baseURL else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

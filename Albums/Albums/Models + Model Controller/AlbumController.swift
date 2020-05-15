//
//  AlbumController.swift
//  Albums
//
//  Created by Clayton Watkins on 5/14/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

class AlbumController {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error{
        case noData
        case noToken
        case failedSignUp
        case failedSignIn
        case tryAgain
        case failedToPost
        case errorDecoding
        case errorEncoding
    }
    
    var albums: [Album] = []
    private let baseURL = URL(string: "https://albums-95e3c.firebaseio.com/")!
    
    
    //MARK: - Methods
    func testDecodingExampleAlbum(){
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: urlPath)
            let exAlbum = try decoder.decode(Album.self, from: data)
            //let exSong = try decoder.decode(Song.self, from: data)
            print(exAlbum)
            //print(exSong)
        } catch {
            print("Error decoding album or song")
        }
    }
    
    func testEncodingExampleAlbum(){
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do{
            let data = try Data(contentsOf: urlPath)
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let encodedAlbum = try encoder.encode(album)
            let albumString = String(data: encodedAlbum, encoding: .utf8)
            print(albumString!)
        } catch{
            print("Error encoding album data")
        }
    }
    
    func getAlbums(completion: @escaping(Result<[String : Album], NetworkError>) -> Void){
        let requestURL = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error{
                completion(.failure(.noData))
                print("Error retriving data: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completion(.failure(.noData))
                    return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let album = try decoder.decode([String : Album].self, from: data)
                self.albums = Array(album.values)
                completion(.success(album))
            } catch {
                print("Error decoding JSON")
                completion(.failure(.errorDecoding))
            }
        }
        task.resume()
    }
    
    func put(album: Album, completion: @escaping (Result<Album, NetworkError>) -> Void) {
        let requestURL = baseURL.appendingPathExtension("json").appendingPathComponent(album.id)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let encoder = JSONEncoder()
            let albumData = try encoder.encode(album)
            request.httpBody = albumData
        } catch {
            completion(.failure(.errorEncoding))
            print("Error encoding album")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error{
                completion(.failure(.failedToPost))
                print("Album failed to post: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completion(.failure(.tryAgain))
                    print("Error posting album to firebase")
                    return
            }
            completion(.success(album))
        }
        task.resume()
    }
    
    func createAlbum(artist: String, coverArt: [URL], genere: [String], name: String, id: String, songs: [Song], completion: @escaping (Result<Album , NetworkError>) -> Void){
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genere, name: name, id: id, songs: songs)
        self.put(album: newAlbum, completion: nil)
        self.albums.append(newAlbum)
    }
    
    func createSong(id: String, name: String, duration: String) -> Song{
        let newSong = Song(id: id, name: name, duration: duration)
        return newSong
    }
    
}

//let artist: String
//let coverArt: [URL]
//let genres: [String]
//let name: String
//let id: String
//let songs: [Song]

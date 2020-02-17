//
//  AlbumController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

// Data(contentsOf: "exampleAlbum.json")

/*
// !!! THIS IS BAD WAY TO DO IT DON"T DO IN YOUR APPS
let url = URL(string: "https://swapi.co/api/people/1/")!
let data = try! Data(contentsOf: url)

let decoder = JSONDecoder()
let luke = try! decoder.decode(Person.self, from: data)

print(luke)

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted]
let lukeData = try! encoder.encode(luke)

let lukeString = String(data: lukeData, encoding: .utf8)
print(lukeString!)
*/

class AlbumController {
    
    // MARK: - Properties
    
    // Data source
    var albums: [Album] = []
    // Firebase Link
    let baseURL = URL(string: "https://albumsap-a518f.firebaseio.com/")!
    // Completion Handler
    typealias CompletionHanlder = (Error?) -> Void
    
    // MARK: - Networking
    
    /// Tests decoding of exampleAlbum.json
    func testDecodingExampleAlbum() {
        print("TEST DECODING CALLED")
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
            
        do {
            let album = try decoder.decode(Album.self, from: data)
            print("This is the DECODING album \(album)")
        } catch {
            NSLog("Error decoding album")
        }
    }
    
    /// Tests encoding of exampleAlbum.json
    func testEncodingExampleAlbum() {
        print("TEST ENCODING CALLED")
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        do {
            let album = try decoder.decode(Album.self, from: data)
            let encodedAlbum = try encoder.encode(album)
            self.albums.append(album)
            print("This is the DECODED album \n\(album)")
            print("\n \n")
            print("This is the ENCODED album: \n")
            let albumString = String(data: encodedAlbum, encoding: .utf8)
            print(albumString!)
        } catch {
            NSLog("Error decoding/encoding album")
        }
    }
    
    /// Should have a completion handler that takes in an optional Error. This function should perform a URLSessionDataTask that fetches the albums from the baseURL, decode them, and sets the albums array to the decoded albums. You should decode the JSON data as [String: Album].self here
    func getAlbums(completion: @escaping (Error?) -> Void) {
        print("called getAlbums")
        
        let getAlbumsURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: getAlbumsURL) { (data, _, error) in
            
            if let error = error {
                print("Error fetching albums: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            guard let data = data else {
                print("No data returned by data task")
                DispatchQueue.main.async {
                    completion(NSError())
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let albums = Array(try decoder.decode([String : Album].self, from: data).values)
                print("ALBUMS = \(albums)")
                self.albums = albums
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                print("Error decoding or storing albums in getAlbums: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }.resume()
    }
    
    /// A function called put(album: Album). This should use a URLSessionDataTask to PUT the album passed into the function to the API. Add the album's identifier to the base URL so it gets put in a unique location in the API.
    func put(album: Album, completion: @escaping CompletionHanlder = { _ in }) {
        print("called put(album)")
        
        let uuid = UUID().uuidString
        
        let requestURL = baseURL.appendingPathComponent("\(uuid)").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        var testAlbum = album
        testAlbum.id = uuid
        
        let encoder = JSONEncoder()
        
        do {
            
            let encodedAlbum = try encoder.encode(testAlbum)
            request.httpBody = encodedAlbum
        } catch {
            NSLog("Error encoding album \(album): \(error)")
            DispatchQueue.main.async {
                completion(error)
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error in sending album to server \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
            
    /// A function called createAlbum. It should take in the necessary properties as parameters in order to initialize a new Album. Create an Album from the method parameters, then append it to the albums array. Then call the put(album: Album) method so the new Album gets saved to the API.
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String = UUID().uuidString, name: String, songs: [Song]) {
        print("called createAlbum")
        
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    /// A function called createSong. It should take in the necessary properties as parameters to be able to initialize a Song. The function should return a Song. In the method, simply initialize a new song from the method parameters and return it.
    func createSong(title: String, duration: String) -> Song {
        print("called createSong")
        
        return Song(name: title, id: UUID().uuidString, duration: duration)
    }
    
    /// A  function called update. This should take in an Album and a parameter for each of the Album object's properties that can be changed (This should be every property). Update the values of the Album parameter, then send those changes to the API by calling the put(album: Album) method.
    func update(albumToUpdate: Album, artist: String, coverArt: [URL], genres: [String], name: String, songs: [Song]) {
        print("called update")
        
        var album = albumToUpdate
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.name = name
        album.songs = songs
        put(album: album)
    }
}

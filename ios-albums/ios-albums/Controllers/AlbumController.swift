//
//  AlbumController.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//
/**
 A function called getAlbums. It should have a completion handler that takes in an optional Error. This function should perform a URLSessionDataTask that fetches the albums from the baseURL, decodes them, and sets the albums array to the decoded albums. Note: You should decode the JSON data as [String: Album].self here.
 
 A function called put(album: Album). This should use a URLSessionDataTask to PUT the album passed into the function to the API. Add the album's identifier to the base URL so it gets put in a unique location in the API.
 
 A function called createAlbum. It should take in the necessary properties as parameters in order to initialize a new Album. Create an Album from the method parameters, then append it to the albums array. Then call the put(album: Album) method so the new Album gets saved to the API.
 
 A function called createSong. It should take in the necessary properties as parameters to be able to initialize a Song. The function should return a Song. In the method, simply initialize a new song from the method parameters and return it.
 
 A function called update. This should take in an Album and a parameter for each of the Album object's properties that can be changed (This should be every property). Update the values of the Album parameter, then send those changes to the API by calling the put(album: Album) method.
 
 Test the createAlbum method by either using the example JSON or passing in your own Album information. Make sure it gets sent to the API, and in the correct structure.
 */
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
private var persistentFileURL: URL? {
    guard let filePath = Bundle.main.path(forResource: "exampleAlbum", ofType: "json") else { return nil }
    return URL(fileURLWithPath: filePath)
}
private let baseURL = URL(string: "https://iosalbums.firebaseio.com/")!

class AlbumController {
    
    var albums: [Album] = []
    
    ///A function called getAlbums. It should have a completion handler that takes in an optional Error. This function should perform a URLSessionDataTask that fetches the albums from the baseURL, decodes them, and sets the albums array to the decoded albums. Note: You should decode the JSON data as [String: Album].self here. = []
    func getAlbums(completion: @escaping (Error?) -> ()) {
        let requestUrl = (baseURL.appendingPathExtension("json"))
        URLSession.shared.dataTask(with: requestUrl) { (data, _, error) in
            if let error = error {
                print("error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("no data returned from data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                self.albums = try jsonDecoder.decode([Album].self , from: data)
                completion(nil)
            } catch {
                print("Error decoding Album: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    ///A function called put(album: Album). This should use a URLSessionDataTask to PUT the album passed into the function to the API. Add the album's identifier to the base URL so it gets put in a unique location in the API.
    func put(album: Album, completion: @escaping () -> () = { }) {
        let uuid = UUID()
        let requestURL = (baseURL
            .appendingPathComponent(uuid.uuidString)
            .appendingPathExtension("json"))
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        let jsonEncoder = JSONEncoder()
        do {
            request.httpBody = try jsonEncoder.encode(album)
//            print(request)
        } catch {
            print("Error encoding album \(album): \(error)")
            completion()
            return
        }
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            guard error == nil else {
                print("Error PUTting album to server: \(error!)")
                completion()
                return
            }
            completion()
        }.resume()
        
    }
    
    ///A function called createAlbum. It should take in the necessary properties as parameters in order to initialize a new Album. Create an Album from the method parameters, then append it to the albums array. Then call the put(album: Album) method so the new Album gets saved to the API.
    func createAlbum(artist: String, coverArt: String, genres: [String], id: String, name: String, songs: [Song]) {
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        albums.append(album)
        put(album: album)
    }
    
    ///A function called createSong. It should take in the necessary properties as parameters to be able to initialize a Song. The function should return a Song. In the method, simply initialize a new song from the method parameters and return it.
    func createSong(duration: String, id: String, name: String) -> Song {
        return Song(duration: duration, id: id, name: name)
    }
    
    ///A function called update. This should take in an Album and a parameter for each of the Album object's properties that can be changed (This should be every property). Update the values of the Album parameter, then send those changes to the API by calling the put(album: Album) method.
    func update(for album: Album, artist: String, coverArt: String, genres: [String], id: String, name: String, songs: [Song]) {
        var updateAlbum = album
        updateAlbum.artist = artist
        updateAlbum.coverArt = coverArt
        updateAlbum.genres = genres
        updateAlbum.id = id
        updateAlbum.name = name
        updateAlbum.songs = songs
        put(album: album)
        
    }

    
    func testDecodingExampleAlbum() {
        
        guard let fileUrl = persistentFileURL else { return }
        URLSession.shared.dataTask(with: fileUrl) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let testAlbum = try jsonDecoder.decode(Album.self, from: data)
                print(testAlbum)
            } catch {
                print("error decoding album: \(error)")
                return
            }
        }.resume()
    }
    
    func testEncodingExampleAlbum() {
        guard let fileUrl = persistentFileURL else { return }
        URLSession.shared.dataTask(with: fileUrl) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = [.prettyPrinted]
            do {
                let decodedTestAlbum = try jsonDecoder.decode(Album.self, from: data)
                print("decoded:", decodedTestAlbum)
                let encodedTestAlbum = try jsonEncoder.encode(decodedTestAlbum)
                print("encoded:", encodedTestAlbum)
                let encodedTestAlbumString = String(data: encodedTestAlbum, encoding: .utf8)!
                print("json:", encodedTestAlbumString)
                
                self.createAlbum(artist: decodedTestAlbum.artist, coverArt: decodedTestAlbum.coverArt, genres: decodedTestAlbum.genres, id: decodedTestAlbum.id, name: decodedTestAlbum.name, songs: decodedTestAlbum.songs)
                
            } catch {
                print("error decoding album: \(error)")
                return
            }
        }.resume()
    }
}

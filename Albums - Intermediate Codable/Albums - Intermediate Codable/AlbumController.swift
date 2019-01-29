
import Foundation

class AlbumController {
    
    // Data source for the application
    var albums: [Album] = []
    
    private let baseURL = URL(string: "https://albums-intermediate-codable.firebaseio.com/")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getAlbums(completion: @escaping CompletionHandler = { _ in }) {
        
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
    
    func put(album: Album, completion: @escaping CompletionHandler = { _ in }) {
        
        do {
            let requestURL = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = "PUT"
            
            let body = try JSONEncoder().encode(album)
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { (_, _, error) in
                if let error = error {
                    NSLog("Error saving album: \(error)")
                }
                completion(error)
            }.resume()
            
        } catch {
            NSLog("Error encoding entry: \(error)")
            completion(error)
            return
        }
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Songs]) {
        
        // Initialize an Album object
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, id: id, name: name, songs: songs)
        
        // Add new album to the albums array
        albums.append(newAlbum)
        
        // Save to the server
        put(album: newAlbum)
    }
    
    func createSong(duration: String, id: String, name: String) -> Songs {
        
        // Initialize a Song object
        let newSong = Songs(duration: duration, id: id, name: name)
        
        return newSong
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], id: String, name: String, songs: [Songs]) {
        
        album.artist = artist
        album.coverArt = coverArt
        album.genres = genres
        album.id = id
        album.name = name
        album.songs = songs
        
        put(album: album)
        
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
        } catch {
            print("Error retrieving data: \(error)")
        }
        
        
        
    }
    
    
}

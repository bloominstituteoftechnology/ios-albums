import Foundation

class AlbumController {
    
    // MARK: - Properties
    
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-f11cd.firebaseio.com/")!
    typealias Completion = (Error?) -> Void
    
    // MARK: - Get
    
    func getAlbums(completion: @escaping Completion) {
        
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if error != nil {
                NSLog("Error perfoeming data task")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                
                let albumDictionary = try decoder.decode([String:Album].self, from: data)
                let values = albumDictionary.map( { $0.value }) // Get values
                self.albums = values
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            }.resume()
        
    }
    
    // MARK: - Put
    
    func put(album: Album, completion: @escaping Completion) {
        
        let url = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "PUT"
        
        
        let encoder = JSONEncoder()
        
        do {
            let encodedAlbum = try encoder.encode(album)
            requestURL.httpBody = encodedAlbum
            completion(nil)
        } catch {
            NSLog("Error encoding Album:\(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if error != nil {
                NSLog("Error econding Album")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    
    // MARK: - Create Album
    
    func createAlbum(artist: String, coverArt: [String], genres: [String], name: String, songs: [Song]) {
        let newAlbum = Album(artist: artist, coverArt: coverArt, genres: genres, name: name, songs: songs)
        albums.append(newAlbum)
        put(album: newAlbum) { (error) in
            if error != nil {
                NSLog("Error putting newAlbum to the server")
            }
        }
    }
    
    
    // MARK: - Create Song
    
    func createSong(duration: String, name: String) -> Song {
        let newSong = Song(duration: duration, name: name)
        return newSong
    }
    
    
    // MARK: - Update Album
    
    func update(album: Album, artist: String, coverArt: [String], genres: [String], name: String, songs: [Song]) {
        guard let index = albums.index(of: album) else { return }
        var theAlbum = albums[index]
        
        theAlbum.artist = artist
        theAlbum.coverArt = coverArt
        theAlbum.genres = genres
        theAlbum.name = name
        theAlbum.songs = songs
        
        albums.remove(at: index)
        albums.insert(theAlbum, at: index)
        
        put(album: theAlbum) { (error) in
            if error != nil {
                NSLog("Error putting updated album to the server")
            }
        }
    }
    
    
    // MARK: - Testing Codable
    
    static func testDecodingExampleAlbum() -> Album? {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("Json file doesn't exist")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print("Decoding successfull")
            return album
        } catch {
            NSLog("Couldn't decoded")
            return nil
        }
    }
    
    static func testEncodingExampleAlbum() {
        guard let album = testDecodingExampleAlbum() else {
            NSLog("Album is nil")
            return
        }
        
        do {
            let _ = try JSONEncoder().encode(album)
            print("Encoding successfull")
        } catch {
            NSLog("Error encoding albums")
        }
    }
}

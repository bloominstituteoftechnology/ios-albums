
import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() {
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("URL not functioning")
            return
        }
        
        do {
            let exampleAlbumData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
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
            let album = try JSONDecoder().decode(Album.self, from: exampleAlbumData)
            print(album)
            let encodedAlbum = try JSONEncoder().encode(album)
            print(String(data: encodedAlbum, encoding: .utf8)!)
        } catch {
            print("Error retrieving data: \(error)")
        }
        
        
        
    }
    
    
}

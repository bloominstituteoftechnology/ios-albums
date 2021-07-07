
import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum() -> Album? {
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            NSLog("JSON file doesn't exist")
            return nil
        }
        
        do {
            // Mimicking getting the JSON from the API.
            let data = try Data(contentsOf: url)
            
            let jsonDecoder = JSONDecoder()
            //            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let album = try jsonDecoder.decode(Album.self, from: data)
            
            print("Success!")
            
            return album
        } catch {
            NSLog("Error decoding Album: \(error)")
            return nil
        }
        
    }
    
}

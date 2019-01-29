
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
    
    
}

import UIKit

// 1. Get URL path for file

let filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")

func getJsonData() {
    do {
        guard let jsonURL = filePath else { return }
        let jsonData = try Data(contentsOf: jsonURL)
        print(String(data: jsonData, encoding: .utf8)!)
    } catch {
        print("error fetching data from file \(error)")
    }
}

getJsonData()

// 2. create our Model

struct Songs: Codable {
    let id: String
    let duration: String
    let title: String
    
    private enum SongCodingKeys: String, CodingKey {
        case id
        case duration
        case name
        
        enum DurationCodingKeys: String, CodingKey {
            case timeLength = "duration"
        }
        
        enum NameCodiingKeys: String, CodingKey {
            case title
        }
    }
    
    init(decoder: Decoder) throws {
        
        // SongsCodingKeys
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        
        // DurationCodingKeys
        var durationContainer = try container.nestedContainer(keyedBy: SongCodingKeys.DurationCodingKeys.self, forKey: .duration)
        self.duration = try durationContainer.decode(String.self, forKey: .timeLength)
        
        // NamedCodingKeys
        var nameContainer = try container.nestedContainer(keyedBy: SongCodingKeys.NameCodiingKeys.self, forKey: .name)
        self.title = try nameContainer.decode(String.self, forKey: .title)
    }
}

struct Album: Codable {
    let artist: String
    let name: String
    let genres: [String]
    let id: String
    let songs: [Songs]
    //let coverArt: [String]
    
    private enum AlbumCodingKeys: String, CodingKey {
        case  artist
        case name
        case genres
        case albumID = "id"
        case songs

        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
        self.artist = try container.decode(String.self, forKey: .artist)
        self.name = try container.decode(String.self, forKey: .name)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.id = try container.decode(String.self, forKey: .albumID)
        
        // Songs Array
        var songs = [Songs]()
        if container.contains(.songs) {
            var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
            
            while !songsContainer.isAtEnd {
                let song = try songsContainer.decode(Songs.self)
                songs.append(song)
            }
        }
        self.songs = songs
    }
}


func parseJson() -> Album? {
    
    var album: Album?
    
    do {
        guard let filePathURL = filePath else { return nil }
        let albumData = try Data(contentsOf: filePathURL)
        let jsonDecoder = JSONDecoder()
        album = try jsonDecoder.decode(Album.self, from: albumData)
    } catch {
        print("error decoding album: \(error)")
        return nil
    }
    return album
}



parseJson()

print(parseJson()!)

// 3. setup partsing methods



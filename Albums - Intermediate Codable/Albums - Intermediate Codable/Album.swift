
import Foundation

struct Album: Decodable {
    
    enum AlbumKeys: String, CodingKey {
        
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum AllCoverArt: String, CodingKey {
            case url
        }
    
    }
    
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var id: String
    var name: String
    var songs: [Songs]
    
    init(from decoder: Decoder) throws {
        
        // Get a container that represents top level of information
        // The top level is a dictionary, so we need a keyed container
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        
        artist = try container.decode(String.self, forKey: .artist)
        
        // coverArt contains an array -> unkeyed container
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArtURLs: [URL] = []
        while coverArtContainer.isAtEnd == false {
            let allCoverArtContainer = try coverArtContainer.nestedContainer(keyedBy: AlbumKeys.AllCoverArt.self)
            let coverArtURLString = try allCoverArtContainer.decode(String.self, forKey: .url)
            if let coverArtURL = URL(string: "\(coverArtURLString)") {
                coverArtURLs.append(coverArtURL)
            }
        }
        coverArt = coverArtURLs
    
        // genre contains an array, but not nested
        genres = try container.decode([String].self, forKey: .genres)
        
        // id not nested inside anything
        id = try container.decode(String.self, forKey: .id)
        
        // name not nested in anything
        name = try container.decode(String.self, forKey: .name)
        
        // songs is an array of the Songs struct
        songs = try container.decode([Songs].self, forKey: .songs)
        
    }
}

struct Songs: Decodable {
    
    enum SongKeys: String, CodingKey {
        
        case duration
        case id
        case name
        
        enum Duration: String, CodingKey {
            case duration
        }
            
        enum Name: String, CodingKey {
            case title
        }
    }
    
    var duration: String
    var id: String
    var name: String
    
    init(from decoder: Decoder) throws {
        
        // Container representing top level of information
        // Songs are inside an array, so we need a keyed container
        let container = try decoder.container(keyedBy: SongKeys.self)
        
        // Duration is a dictionary -> keyed container
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.Duration.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        
        // Name is a dictionary -> keyed container
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.Name.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey: .title)
        
        // Not nested inside anything
        id = try container.decode(String.self, forKey: .id)
    }
    
}

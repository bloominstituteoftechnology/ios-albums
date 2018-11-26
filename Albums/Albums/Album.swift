import Foundation


struct Album: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case artist
        case coverArt
        case genres
        case id
        case name
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey {
            case url
        }
    }
    
    func encode(to encoder: Encoder) {
        
        // encoder here
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        
        var coverArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var coverArt: [String] = []
        
        while !coverArtContainer.isAtEnd {
            
            let smallCoverArtContainer = try coverArtContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            
            let art = try smallCoverArtContainer.decode(String.self, forKey: .url)
            
            coverArt.append(art)
        }
        
        let genres = try container.decode([String].self, forKey: .genres)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let songs = try container.decode([Song].self, forKey: .songs)
        
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.id = id
        self.name = name
        self.songs = songs
        
    }
    
    let artist: String
    let coverArt: [String]
    let genres: [String]
    let id: String
    let name: String
    let songs: [Song]
    
}




struct Song: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case duration
        case id
        case name
        
        enum DurationCodingKeys: String, CodingKey {
            case duration
        }
        
        enum NameCodingKeys: String, CodingKey {
            case title
        }
        
    }
    
    func encode(to encoder: Encoder) {
        
        //encoder here
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let durationContainer = try container.nestedContainer(keyedBy: CodingKeys.DurationCodingKeys.self, forKey: .duration)
        
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let id = try container.decode(String.self, forKey: .id)
        
        let nameContainer = try container.nestedContainer(keyedBy: CodingKeys.NameCodingKeys.self, forKey: .name)
        
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        self.duration = duration
        self.id = id
        self.name = name
        
    }
    
    let duration: String
    let id: String
    let name: String
    
}

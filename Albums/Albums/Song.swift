import Foundation

struct Song: Codable, Equatable {
    
    // MARK: - Properties
    
    var duration: String
    var id: String
    var name: String
    
    // MARK: - Model initializer
    
    init(duration: String, id: String = UUID().uuidString, name: String) {
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    // MARK: - CodingKey
    
    enum SongKeys: String, CodingKey {
        case duration
        case id
        case name
        
        enum DurationKeys: String, CodingKey {
            case duration
        }
        
        enum NameKeys: String, CodingKey {
            case title
        }
    }
    
    // MARK: - Decoding
    
    init(from decoder: Decoder) throws {
        let songContainer = try decoder.container(keyedBy: SongKeys.self)
        
        let durationContainer = try songContainer.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        let duration = try durationContainer.decode(String.self, forKey: .duration)
        
        let id = try songContainer.decode(String.self, forKey: .id)
        
        let nameContainer = try songContainer.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        let name = try nameContainer.decode(String.self, forKey: .title)
        
        self.duration = duration
        self.id = id
        self.name = name
    }
    
    // MARK: - Encoding
    
    func encode(to encoder: Encoder) throws {
        var songContainer = encoder.container(keyedBy: SongKeys.self)
        
        var durationContainer = songContainer.nestedContainer(keyedBy: SongKeys.DurationKeys.self, forKey: .duration)
        try durationContainer.encode(duration, forKey: .duration)
        
        try songContainer.encode(id, forKey: .id)
        
        var nameContainer = songContainer.nestedContainer(keyedBy: SongKeys.NameKeys.self, forKey: .name)
        try nameContainer.encode(name, forKey: .title)
    }
    
}

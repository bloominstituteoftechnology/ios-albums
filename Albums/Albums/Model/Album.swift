//
//  Song.swift
//  Albums
//
//  Created by Harmony Radley on 4/9/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation

var filePath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
func printJsonData() {
  do {
    guard let jsonURL = filePath else { return }
    let jsonData = try Data(contentsOf: jsonURL)
    print(String(data: jsonData, encoding: .utf8)!)
  } catch {
    print("error fetching data from file \(error)")
  }
}
//2. create out Model
struct CoverArt: Codable {
  let url: URL
}
struct Album: Codable {
  let artist: String
  let name: String
  let id: String
  let genres: [String]
  let coverArt: [CoverArt]
  let songs: [Song]
  private enum AlbumCodingKeys: String, CodingKey {
    case artist
    case name
    case coverArt
    case genres
    case id
    case songs
    enum CoverArtCodingKey: String, CodingKey {
      case url
    }
  }
  struct Song: Codable, Equatable {
    enum SongKeys: String, CodingKey {
      case id
      case duration
      case name
      enum DurationDescptionKeys: String, CodingKey {
        case duration
      }
      enum NameDescriptionKeys: String, CodingKey {
        case title
      }
    }
    var duration: String
    var id: UUID
    var title: String
    init(id: UUID, duration: String, title: String) {
      self.id = id
      self.title = title
      self.duration = duration
    }
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: SongKeys.self)
      id = try container.decode(UUID.self, forKey: .id)
      let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationDescptionKeys.self, forKey: .duration)
      duration = try durationContainer.decode(String.self, forKey: .duration)
      let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.self, forKey: .name)
      title = try nameContainer.decode(String.self, forKey: .title)
    }
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: SongKeys.self)
      try container.encode(id, forKey: .id)
      var durationContainer = container.nestedContainer(keyedBy: SongKeys.DurationDescptionKeys.self, forKey: .duration)
      try durationContainer.encode(duration, forKey: .duration)
      var nameContainer = container.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.self, forKey: .name)
      try nameContainer.encode(title, forKey: .title)
    }
    static func == (lhs: Song, rhs: Song) -> Bool {
      return lhs.id == rhs.id
    }
  }
  init(decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: AlbumCodingKeys.self)
    self.artist = try container.decode(String.self, forKey: .artist)
    self.name = try container.decode(String.self, forKey: .name)
    self.genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
    self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
    let newSongs = try container.decodeIfPresent([Song].self, forKey: .songs)
    self.songs = newSongs ?? []
    // because it lives inside the array
    var urls = [CoverArt]()
    let covertArtContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
    while !covertArtContainer.isAtEnd {
      var coverArtContainer = try container.nestedContainer(keyedBy: AlbumCodingKeys.CoverArtCodingKey.self, forKey: .coverArt)
      let coverArt = try coverArtContainer.decode(CoverArt.self, forKey: .url)
      urls.append(coverArt)
    }
    self.coverArt = urls
  }
}
// as we are dealing with local json so the things are going to be a little bit different.
func parseJson() -> Album? {
  var album: Album?
  do {
    guard let filePathURL = filePath else { return nil }
    let albumData = try Data(contentsOf: filePathURL)
    let jsonDecoder = JSONDecoder()
    album = try jsonDecoder.decode(Album.self, from: albumData)
  } catch {
    print("error decoding the album: \(error)")
    return nil
  }
  return album
}


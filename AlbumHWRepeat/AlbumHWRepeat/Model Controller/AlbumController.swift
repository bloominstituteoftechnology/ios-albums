//
//  AlbumController.swift
//  AlbumHWRepeat
//
//  Created by Michael Flowers on 6/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class AlbumController {
    
    func testDecodingExampleAlbum(){
        guard let bundleData = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("Error with bundle") ; return }
        do {
            let decode = JSONDecoder()
            let data = try! Data(contentsOf: bundleData)
            let song = try decode.decode(Album.self, from: data)
            print("this is the song: \(song.artist)")
        } catch  {
            print("this is the error: \(error.localizedDescription), this is a better definition: \(error)")
        }
    }
    
    func testEncodingExampleAlbum(){
        guard let bundleData = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { print("Error with bundle") ; return }
        do {
            let decode = JSONDecoder()
            let data = try! Data(contentsOf: bundleData)
            let song = try decode.decode(Album.self, from: data)
            let jsonEncode = JSONEncoder()
            jsonEncode.outputFormatting = [.prettyPrinted, .sortedKeys]
          let songData = try jsonEncode.encode(song)
            let songString = String(data: songData, encoding: .utf8)!
            print("songString: \(songString)")
        } catch  {
            print("this is the error: \(error.localizedDescription), this is a better definition: \(error)")
        }
    }
}

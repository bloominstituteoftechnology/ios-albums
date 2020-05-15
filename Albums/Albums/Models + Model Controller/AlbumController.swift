//
//  AlbumController.swift
//  Albums
//
//  Created by Clayton Watkins on 5/14/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

class AlbumController {
    
    
    
    
    //MARK: - Methods
    func testDecodingExampleAlbum(){
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: urlPath)
            let exAlbum = try decoder.decode(Album.self, from: data)
            //let exSong = try decoder.decode(Song.self, from: data)
            print(exAlbum)
            //print(exSong)
        } catch {
            print("Error decoding album or song")
        }
    }
    
    func testEncodingExampleAlbum(){
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted]
            let data = try Data(contentsOf: urlPath)
            let albumData = try encoder.encode(data)
            let albumString = String(data: albumData, encoding: .utf8)
            print(albumString!)
        } catch{
            print("Error encoding album data")
        }
    }
}

//
//  AlbumController.swift
//  Albums
//
//  Created by Yvette Zhukovsky on 11/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation



class AlbumController {
    
     var album: [Album] = []
     let baseURL = URL(string: "https://albumns-ba3fc.firebaseio.com/")!
    
    
    func getAlbums(completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) {(data, _, error) in
            
            if let error = error {
                NSLog("Error perfoeming data task")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let albumDict = try decoder.decode([String:Album].self, from: data)
                
            }catch {
                
                NSLog("Error")
                completion(error)
                return

            }
         completion(nil)
        }.resume()
  
    }
    
   
    
    func put(album: Album, completion: @escaping (Error?)-> Void){
        
        let url = baseURL.appendingPathComponent(album.id).appendingPathExtension("json")
    }
    
    
   static func testDecodingExampleAlbum(){
   
    guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
        
        NSLog("JSON file doesn't exist")
        return
    }
    
    do {
        // Mimicking getting the JSON from the API.
        let data = try Data(contentsOf: url)
        
        let jsonDecoder = try JSONDecoder().decode(Album.self, from: data)
        
        print("Success!")
        
       
    } catch {
        NSLog("Error decoding\(error)")

    }
    }
    
        

    static func testEncodingExampleAlbum(){
        
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            
            NSLog("JSON file doesn't exist")
            return
        }
      
        do{
            
            let data  = try Data(contentsOf: url)
            let jsonDecoder = try JSONDecoder().decode(Album.self, from: data)
            _ = try JSONEncoder().encode(jsonDecoder)
             print("Success!")
        }catch {
           NSLog("Error encoding\(error)")
            
        }
        
    }
    
    
    
    
    }
    


//
//  AlbumController.swift
//  Albums
//
//  Created by Kelson Hartle on 5/6/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation

class AlbumController {
    
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        
        case noData, tryagain
    }
    
    var albums: [Album] = []
    
    //var baseURL = URL(string: <#T##String#>)
    
    private lazy var jsonDecoder = JSONDecoder()
    
//    func getAlbums(completion: @escaping (Result<[Album], NetworkError>) -> Void) {
//
//        var request = URLRequest(url: )
//        request.httpMethod = HTTPMethod.get.rawValue
//
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error receiving album data: \(error)")
//                completion(.failure(.tryagain))
//                return
//            }
//            if let response = response as? HTTPURLResponse,
//                response.statusCode == 401 {
//                completion(.failure(.tryagain))
//            }
//
//            guard let data = data else {
//                print("No data received from getAlbums")
//                completion(.failure(.noData))
//            }
//
//            do {
//                self.albums = try self.jsonDecoder.decode([String: Album].self, from: data)
//            } catch {
//
//
//            }
//
//        }
//
//    }
    
    func testDecodingExampleAlbum() {
        
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        let jsonData = try! Data(contentsOf: urlPath)
        
        let decoder = JSONDecoder()
        
    }
    
}

//
//  AlbumController.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

final class AlbumController {
    
    // MARK: Properties
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    enum NetworkError: Error {
        case failedFetch, badURL, badData
        case failedPut
        case failedPost
    }
    
    let decoder = JSONDecoder()
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    var albums = [Album]()
    let baseURL: URL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    
    // MARK: - Functions
    
    private func getAlbumList(completion: @escaping (Result<Bool, NetworkError>) -> Void ) {
        let request = apiRequest(for: baseURL, responseType: .get)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Fetch albums failed with error: \(error.localizedDescription)")
                completion(.failure(.failedFetch))
            }
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    print("Returned bad response")
                    return completion(.failure(.failedFetch))
            }
            guard let data = data else {
                print("Data was void")
                return completion(.failure(.badData))
            }
            
            do {
                let albums = try self.decoder.decode([Album].self, from: data)
                self.albums = albums
                completion(.success(true))
            } catch {
                print("Error decoding albums: \(error.localizedDescription)")
                completion(.failure(.failedFetch))
            }
        }
    }
    
    private func changeAlbum(for album: Album, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let albumURL = baseURL.appendingPathComponent(album.id)
        let request = apiRequest(for: albumURL, responseType: .put)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
    }
    
    // MARK: - Helper Methods
    
    private func apiRequest(for url: URL, responseType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = responseType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - Codable Tests
    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {return}
        
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try decoder.decode(Album.self, from: data)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {return}
        
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try decoder.decode(Album.self, from: data)
//            print(result)
            
            let encoded = try encoder.encode(result)
            print(String(data: encoded, encoding: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
    }
}

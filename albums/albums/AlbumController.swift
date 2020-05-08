//
//  AlbumController.swift
//  albums
//
//  Created by ronald huston jr on 5/7/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation

class AlbumController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        case failedFetch, badURL, badData
        case failedPost
    }
    
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    let decoder = JSONDecoder()
    
    var albums = [Album]()
    let baseURL: URL = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
    
    func getAlbumList(completion: @escaping (Result<Bool, NetworkError>) -> Void ) {
        let request = apiRequest(url: baseURL, responseType: .get)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("fetch request failed with error: \(error)")
                completion(.failure(.failedFetch))
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200
                else {
                    print("fetch request returned non-200 response")
                    completion(.failure(.failedFetch))
                    return
            }
            
            guard let data = data else {
                print("data not available")
                completion(.failure(.failedFetch))
                return
            }
                //  sets the albums array to the decoded albums
            do {
                let albums = try self.decoder.decode([Album].self, from: data)
                self.albums = albums
                completion(.success(true))
            } catch {
                print("error decoding albums: \(error)")
                completion(.failure(.failedFetch))
            }
        }
    }
    
    //  MARK: - helper method to build http method
    private func apiRequest(url: URL, responseType: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = responseType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try decoder.decode(Album.self, from: data)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testEncodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: urlPath)
            let result = try decoder.decode(Album.self, from: data)
            
            let encoded = try encoder.encode(result)
            print(encoded)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

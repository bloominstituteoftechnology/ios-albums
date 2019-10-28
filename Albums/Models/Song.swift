//
//  Song.swift
//  Albums
//
//  Created by macbook on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Song: Codable {
    let title: String
    let duration: String
    let id: Int
    
    init(from decoder: Decoder) throws {
        
    }
    
}

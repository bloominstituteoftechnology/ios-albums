//
//  Song.swift
//  Albums Sprint Challenge
//
//  Created by Elizabeth Wingate on 3/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Song: Decodable, Encodable {

   // MARK: - Properties
   var duration: String
   var id: String
   var name: String

    enum CodingKeys: String, CodingKey {
    case duration, id, name

    enum DurationCodingKeys: String, CodingKey {
        case duration
    }

    enum NameCodingKeys: String, CodingKey {
        case title
    }
  }
}

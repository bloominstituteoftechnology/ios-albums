//
//  Networking Helpers.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import Foundation

/// HTTPMethod is an enum that holds the strings of possible HTTP Request Methods. Use .rawValue instead of writing a string.
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

typealias CompletionHandler = (Error?) -> Void

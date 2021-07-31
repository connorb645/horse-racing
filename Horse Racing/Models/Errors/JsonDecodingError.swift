//
//  JsonDecodingError.swift
//  Horse Racing
//
//  Created on 30/07/2021.
//

import Foundation

/// Errors to throw when JsonFileDecoder fails
enum JsonDecodingError: Error {
    case decodingFailedWithMessage(_ message: String)
}

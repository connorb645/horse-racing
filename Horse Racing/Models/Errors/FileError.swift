//
//  FileError.swift
//  Horse Racing
//
//  Created on 30/07/2021.
//

import Foundation

/// Errors to throw when FileReader fails.
enum FileError: Error {
    case noFileFoundWithName(_ name: String)
    case dataExtractionError
}

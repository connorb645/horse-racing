//
//  FileError.swift
//  Horse Racing
//
//  Created by Connor Black on 30/07/2021.
//

import Foundation


enum FileError: Error {
    case noFileFoundWithName(_ name: String)
    case dataExtractionError
}

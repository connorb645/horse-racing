//
//  JsonFileDecoder.swift
//  Horse Racing
//
//  Created on 30/07/2021.
//

import Foundation

/// Used to decode Json Data into an object
struct JsonFileDecoder {
    
    /// Will decode a Data object containing JSON into a specified model
    /// - Parameter data: The data representation of the JSON structure.
    /// - Throws: A JsonDecodingError if the decoder fails to decode the Data
    /// - Returns: The object once decoded from the Data
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch(let e) {
            throw JsonDecodingError.decodingFailedWithMessage(e.localizedDescription)
        }
    }
}

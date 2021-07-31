//
//  TestUser.swift
//  Horse RacingTests
//
//  Created by Connor Black on 30/07/2021.
//

import Foundation

/// Object to help with tests.
struct TestUser: Decodable {
    let name: String
    let address: String
    let children: [TestUser]?
}

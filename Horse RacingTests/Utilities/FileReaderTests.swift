//
//  FileReaderTests.swift
//  Horse RacingTests
//
//  Created by Connor Black on 30/07/2021.
//

import XCTest
@testable import Horse_Racing

class FileReaderTests: XCTestCase {

    func testCanReadJsonFile() {
        let bundle = Bundle.init(for: type(of: self))
        
        let fileReader = FileReader(inBundle: bundle)
        
        do {
            let data = try fileReader.readData(fromFile: "testData", ofType: .json)
            
            XCTAssertNotNil(data)
            XCTAssertFalse(data.isEmpty)
            
        } catch (let exception) {
            XCTFail(exception.localizedDescription)
        }
    }

}

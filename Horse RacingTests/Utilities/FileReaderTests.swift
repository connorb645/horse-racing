//
//  FileReaderTests.swift
//  Horse RacingTests
//
//  Created on 30/07/2021.
//

import XCTest
@testable import Horse_Racing

class FileReaderTests: XCTestCase {
    
    /// Test to ensure the FileReader is able to read json data from a file within a specified bundle.
    func testCanReadJsonFile() {
        let bundle = Bundle.init(for: type(of: self))
        
        let fileReader = FileReader(inBundle: bundle)
        
        do {
            let data = try fileReader.readData(fromFile: "SimpleDataStructureData")
            
            XCTAssertNotNil(data)
            XCTAssertFalse(data.isEmpty)
            
        } catch (let exception) {
            XCTFail(exception.localizedDescription)
        }
    }
    
    
    /// Test to ensure that the correct FileError is thrown when a file which doesn't exist is requested.
    func testThrowsCorrectExceptionForFileNotFound() {
        let bundle = Bundle.init(for: type(of: self))
        
        let fileReader = FileReader(inBundle: bundle)
        
        do {
            let _ = try fileReader.readData(fromFile: "incorrectFileName", ofType: .json)
            XCTFail("Text failed due to successfully reading a file which doesn't exist in the bundle.")
        } catch FileError.noFileFoundWithName(let name) {
            XCTAssertEqual(name, "incorrectFileName")
        } catch {
            XCTFail("Test failed due to incorrect exception returned.")
        }
    }

}

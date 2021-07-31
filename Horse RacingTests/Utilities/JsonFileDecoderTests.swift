//
//  JsonFileDecoderTests.swift
//  Horse RacingTests
//
//  Created on 30/07/2021.
//

import XCTest
@testable import Horse_Racing

class JsonFileDecoderTests: XCTestCase {
    
    /// Test to ensure the JsonFileDecoder is able to decode a simple String from a JSON file.
    func testCanDecodeStringFromFile() {
        let jsonFileDecoder = JsonFileDecoder()
        
        getDataFromFileName("SimpleDataStructureData") { data in
            do {
                let result: String = try jsonFileDecoder.decode(data: data)
                XCTAssertNotNil(result)
                XCTAssertEqual(result, "Result string")
            } catch {
                XCTFail("Test Failed because we failed to decode the data.")
            }
        }
    }
    
    
    /// Test to ensure the correct error is given when trying to decode from a file having specified an incorrect type.
    func testDecodeFailureErrorIsCorrect() {
        let jsonFileDecoder = JsonFileDecoder()
        
        getDataFromFileName("SimpleDataStructureData") { data in
            do {
                let _: Int = try jsonFileDecoder.decode(data: data)
                XCTFail("Test failed since we managed to decode a string as an Int")
            } catch JsonDecodingError.decodingFailedWithMessage(_) {
                XCTAssert(true)
                return
            } catch (let e) {
                XCTFail("Failed to decode json from data for some reason: \(e.localizedDescription)")
                return
            }
        }
    }
    
    /// Test to ensure we can correctly decode a TestUser model.
    func testCanDecodeSimpleModelFromFile() {
        let jsonFileDecoder = JsonFileDecoder()
        
        getDataFromFileName("SimpleModelData") { data in
            do {
                let result: TestUser = try jsonFileDecoder.decode(data: data)
                XCTAssertNotNil(result)
                XCTAssertEqual(result.name, "John Lennon")
                XCTAssertEqual(result.address, "251 Menlove Avenue")
                XCTAssertTrue(result.children?.count == 2)
                XCTAssertEqual(result.children?[0].name, "Sean Lennon")
                XCTAssertEqual(result.children?[0].address, "251 Menlove Avenue")
                XCTAssertEqual(result.children?[1].name, "Julian Lennon")
                XCTAssertEqual(result.children?[1].address, "251 Menlove Avenue")
            } catch {
                XCTFail("Test failed because we failed to decode simple model.")
            }
        }
    }
    
    /// Test to ensure we can decode an array of TestUser
    func testCanDecodeMultipleSimpleModelsFromFile() {
        let jsonFileDecoder = JsonFileDecoder()
        
        getDataFromFileName("SimpleModelsData") { data in
            do {
                let result: [TestUser] = try jsonFileDecoder.decode(data: data)
                
                XCTAssertNotNil(result)
                XCTAssertTrue(result.count == 2)
            } catch {
                XCTFail("Test failed because we failed to decode multiple simple models.")
            }
        }
    }
    
    /// Used to read data from a file and return the data in completion block.
    /// - Parameters:
    ///   - name: The file name
    ///   - task: Completion block to execute once the file data has been successfully read
    /// - Returns: Data read from file within completion handler
    func getDataFromFileName(_ name: String, onCompletion task: (Data) -> ()) {
        let bundle = Bundle.init(for: type(of: self))
        let fileReader = FileReader(inBundle: bundle)
        
        do {
            let data = try fileReader.readData(fromFile: name)
            task(data)
        } catch FileError.noFileFoundWithName(let fileName) {
            XCTFail("File \(fileName) not found in bundle.")
        } catch FileError.dataExtractionError {
            XCTFail("Failed to extract data from file.")
        } catch (let e) {
            XCTFail("Failed to read data from file for reason: \(e.localizedDescription)")
        }
    }

    
}

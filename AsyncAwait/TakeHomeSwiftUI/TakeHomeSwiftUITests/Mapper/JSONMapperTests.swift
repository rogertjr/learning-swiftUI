//
//  JSONMapperTests.swift
//  TakeHomeSwiftUITests
//
//  Created by Rogério Toledo on 22/08/22.
//

import XCTest
@testable import TakeHomeSwiftUI

class JSONMapperTests: XCTestCase {

    func testWithValidJsonSuccessfullyDecodes() {
        XCTAssertNoThrow(try JSONMapper.decode(MockResponseFiles.users.rawValue, type: Users.self),
                         "Mapper shouldn't throw an error")
        
        let usersResponse = try? JSONMapper.decode(MockResponseFiles.users.rawValue, type: Users.self)
        XCTAssertNotNil(usersResponse)
        
        XCTAssertEqual(usersResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(usersResponse?.perPage, 6, "Items per page should be 6")
        XCTAssertEqual(usersResponse?.total, 12, "Total should be 12")
        XCTAssertEqual(usersResponse?.totalPages, 2, "Total of pages should be 2")
    }
    
    func testWithMissingFileErrorThrown() {
        XCTAssertThrowsError(try JSONMapper.decode("", type: Users.self),
                             "An error shoud be thrown")
        
        do {
            _ = try JSONMapper.decode("", type: Users.self)
        } catch {
            guard let mappingError = error as? JSONMapper.MappingError else {
                XCTFail("This is wrong mapping error")
                return
            }
            
            XCTAssertEqual(mappingError, JSONMapper.MappingError.failedToGetContents,
                           "This should be a failed to get contents error")
        }
    }
    
    func testWithInvalidFileNameErrorThrown() {
        XCTAssertThrowsError(try JSONMapper.decode("test", type: Users.self),
                             "An error shoud be thrown")
        
        do {
            _ = try JSONMapper.decode("test", type: Users.self)
        } catch {
            guard let mappingError = error as? JSONMapper.MappingError else {
                XCTFail("This is wrong mapping error")
                return
            }
            
            XCTAssertEqual(mappingError, JSONMapper.MappingError.failedToGetContents,
                           "This should be a failed to get contents error")
        }
    }
    
    func testWithInvalidJsonErrorTrhown() {
        XCTAssertThrowsError(try JSONMapper.decode(MockResponseFiles.users.rawValue, type: UserDetail.self),
                             "An error shoud be thrown")
        
        do {
            _ = try JSONMapper.decode("UsersResponse", type: UserDetail.self)
        } catch {
            if error is JSONMapper.MappingError {
                XCTFail("This is wrong mapping error")
            }
        }
    }
}

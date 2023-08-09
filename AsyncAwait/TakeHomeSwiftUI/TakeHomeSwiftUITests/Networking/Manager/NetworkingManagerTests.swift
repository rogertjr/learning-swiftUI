//
//  NetworkingManagerTests.swift
//  TakeHomeSwiftUITests
//
//  Created by Rogério Toledo on 26/08/22.
//

import XCTest
@testable import TakeHomeSwiftUI

class NetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        url = nil
        session = nil
    }
    
    func testWithSuccessfulResponseIsValid() async throws {
        guard let path = Bundle.main.path(forResource: "UsersResponse", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static json users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, data)
        }
        
        let result = try await NetworkingManager.shared.request(session,
                                                                endpoint: .people(1),
                                                                type: Users.self)
        
        let staticJSON = try JSONMapper.decode("UsersResponse", type: Users.self)
        XCTAssertEqual(result, staticJSON, "The returned response shoubl be decoded properly")
        
    }
    
    func testWithSuccessfulResponseVoidIsValid() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, nil)
        }
        
        _ = try await NetworkingManager.shared.request(session,
                                                       endpoint: .people(1))
    }
    
    func testWithUnsuccessfullResponseCodeInInvalidRange() async {
        let statusCode = 400
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                          statusCode: statusCode,
                                          httpVersion: nil,
                                          headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session,
                                                           endpoint: .people(1),
                                                           type: Users.self)
        } catch {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Wrong error type, expecting a NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode),
                           "Error should be a networking error which throws an invlaid status code")
        }
    }
    
    func testWithUnsuccessfullResponseCodeVoidInInvalidRange() async {
        let statusCode = 400
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                          statusCode: statusCode,
                                          httpVersion: nil,
                                          headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session,
                                                           endpoint: .people(1))
        } catch {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Wrong error type, expecting a NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode),
                           "Error should be a networking error which throws an invlaid status code")
        }
    }
}

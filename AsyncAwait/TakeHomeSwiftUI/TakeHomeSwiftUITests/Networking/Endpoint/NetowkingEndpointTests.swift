//
//  NetowkingEndpointTests.swift
//  TakeHomeSwiftUITests
//
//  Created by Rogério Toledo on 26/08/22.
//

import XCTest
@testable import TakeHomeSwiftUI

class NetowkingEndpointTests: XCTestCase {

    func testWithPeopleEnpointRequestIsValid() {
        let endpoint = Endpoint.people(1)
        XCTAssertEqual(endpoint.base, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The host should be /api/users")
        XCTAssertEqual(endpoint.method, .GET, "The method should be GET")
        XCTAssertEqual(endpoint.queryItems, ["page":"1"], "The query items should be page:1")
        
        XCTAssertEqual(endpoint.url?.absoluteString,
                       "https://reqres.in/api/users?page=1&delay=2",
                       "The generated url doesnt match")
    }
    
    func testWithDetailEnpointRequestIsValid() {
        let userID = 1
        let endpoint = Endpoint.detail(userID)
        XCTAssertEqual(endpoint.base, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/\(userID)", "The host should be /api/users/\(userID)")
        XCTAssertEqual(endpoint.method, .GET, "The method should be GET")
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString,
                       "https://reqres.in/api/users/\(userID)?delay=2",
                       "The generated url doesnt match")
    }
    
    func testWithCreateEnpointRequestIsValid() {
        let endpoint = Endpoint.create(nil)
        XCTAssertEqual(endpoint.base, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The host should be /api/users")
        XCTAssertEqual(endpoint.method, .POST(nil), "The method should be POST")
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString,
                       "https://reqres.in/api/users?delay=2",
                       "The generated url doesnt match")
    }
}

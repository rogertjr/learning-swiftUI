//
//  CreatFormValidatorTests.swift
//  TakeHomeSwiftUITests
//
//  Created by Rogério Toledo on 23/08/22.
//

import XCTest
@testable import TakeHomeSwiftUI

class CreatFormValidatorTests: XCTestCase {
    
    private var validator: CreateValidator!
    
    override func setUp() {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }

    func testWithEmptyPersonFirstNameErrorThrown() {
        let person = Person()
        
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty first name should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validatorError = error as? CreateValidator.CreateValidatorErrors else {
                XCTFail("Got wrong expecting error")
                return
            }
            XCTAssertEqual(validatorError,
                           CreateValidator.CreateValidatorErrors.invalidFirtName,
                           "Expecting error for invalid first name")
        }
    }
    
    func testWithEmptyPersonLastNameErrorThrown() {
        let person = Person(firstName: "Roger")
        
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty last name should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validatorError = error as? CreateValidator.CreateValidatorErrors else {
                XCTFail("Got wrong expecting error")
                return
            }
            XCTAssertEqual(validatorError,
                           CreateValidator.CreateValidatorErrors.invalidLastName,
                           "Expecting error for invalid last name")
        }
    }
    
    func testWithEmptyPersonJobErrorThrown() {
        let person = Person(firstName: "Roger", lastName: "Toledo")
        
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty job should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validatorError = error as? CreateValidator.CreateValidatorErrors else {
                XCTFail("Got wrong expecting error")
                return
            }
            XCTAssertEqual(validatorError,
                           CreateValidator.CreateValidatorErrors.invalidJob,
                           "Expecting error for invalid job")
        }
    }
    
    func testWithValidPersonJobNotErrorThrown() {
        let person = Person(firstName: "Roger", lastName: "Toledo", job: "iOS Dev")
        
        XCTAssertNoThrow(try validator.validate(person), "No error should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            XCTFail("No error should be thrown for a valid object")
        }
    }
}

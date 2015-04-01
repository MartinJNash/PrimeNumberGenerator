//
//  PrimeNumberGeneratorTests.swift
//  Primer
//
//  Created by Martin Nash on 3/31/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

import UIKit
import XCTest
import Primer

class PrimeNumberGeneratorTests: XCTestCase {

    let firstTen = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    let generator = PrimeNumberGenerator()

    func testFirstXPrimes() {
        let ct = 10
        let numbers = generator.firstXPrimes(ct)

        XCTAssert(numbers.count == ct)
        XCTAssert(numbers == firstTen)
    }
    
    func testOrdinalPrimes() {

        for x in 0..<firstTen.count {
            XCTAssert(firstTen[x] == generator.nthPrime(x+1))
        }
    }
    
    
}

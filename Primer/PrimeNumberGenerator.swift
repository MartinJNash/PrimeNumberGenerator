//
//  PrimeNumberGenerator.swift
//  Primer
//
//  Created by Martin Nash on 3/31/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

import Foundation

public class PrimeNumberGenerator {

    private var knownPrimes: [Int] = [2, 3]

    public init() {
        
    }
    
    private func isPrime(num: Int) -> Bool {
        
        // two and three are prime
        if num == 2 {
            return true
        }
        
        if num == 3 {
            return true
        }
        
        // other evens are not prime
        if num % 2 == 0 {
            return false
        }
        
        // can't be less than two
        if num < 2 {
            return false
        }
        
        
        var limit = Int(sqrt(Float(num)))
        
        for i in 2...limit {
            if num % i == 0 {
                return false
            }
        }
        
        return true
    }
    
    public func firstXPrimes(count: Int) -> [Int] {
        
        while knownPrimes.count < count {

            let lastPrime = knownPrimes.last ?? 0
            
            var candidate = lastPrime + 1
            while !isPrime(candidate) {
                candidate++
            }
            
            knownPrimes.append(candidate)
            
        }

        return Array<Int>(knownPrimes[0..<count])
    }
    
    public func nthPrime(n: Int) -> Int {
        return firstXPrimes(n).last!
    }

}



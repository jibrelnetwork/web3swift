//
//  Web3+Miner.swift
//  web3swift
//
//  Created by Bogdan Baglai on 03.10.2018.
//  Copyright © 2018 Jibral Network. All rights reserved.
//

import Foundation
import BigInt
import Result

extension web3.Miner {
    
    /// Returns todo.
    ///
    /// Start mining
    ///
    /// Returns the Result object that indicates either success of failure.
    
    public func start(numThreads: Int) -> Result<BigUInt, Web3Error> {
        do {
            let result = try self.startPromise(numThreads: numThreads).wait()
            return Result(result)
        } catch {
            if let err = error as? Web3Error {
                return Result.failure(err)
            }
            return Result.failure(Web3Error.generalError(err: error))
        }
    }
}


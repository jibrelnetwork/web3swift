//
//  Promise+Web3+Miner+Start.swift
//  web3swift
//
//  Created by Bogdan Baglai on 03.10.2018.
//  Copyright © 2018 Jibral Network. All rights reserved.
//


import Foundation
import PromiseKit
import BigInt

extension web3.Miner {
    public func startPromise(numThreads: Int) -> Promise<BigUInt> {
        let request = JSONRPCRequestFabric.prepareRequest(.minerStart, parameters: [numThreads])
        let rp = web3.dispatch(request)
        let queue = web3.requestDispatcher.queue
        return rp.map(on: queue ) { response in
            guard let value: BigUInt = response.getValue() else {
                if response.error != nil {
                    throw Web3Error.nodeError(desc: response.error!.message)
                }
                throw Web3Error.nodeError(desc: "Invalid value from Ethereum node")
            }
            return value
        }
    }
}


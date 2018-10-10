//
//  Promise+Web3+Personal+NewAccount.swift
//  web3swift
//
//  Created by bogdan on 03.10.2018.
//

import Foundation
import BigInt
import PromiseKit

extension web3.Personal {
    
    func newAccountPromise(password:String = "web3swift") -> Promise<Bool> {
        let queue = web3.requestDispatcher.queue
        do {
            if self.web3.provider.attachedKeystoreManager == nil {
                let request = JSONRPCRequestFabric.prepareRequest(.newAccount, parameters: [password])
                return self.web3.dispatch(request).map(on: queue) {response in
                    guard let value: Bool = response.getValue() else {
                        if response.error != nil {
                            throw Web3Error.nodeError(desc: response.error!.message)
                        }
                        throw Web3Error.nodeError(desc: "Invalid value from Ethereum node")
                    }
                    return value
                }
            }
            throw Web3Error.inputError(desc: "Can not create new account")
        } catch {
            let returnPromise = Promise<Bool>.pending()
            queue.async {
                returnPromise.resolver.reject(error)
            }
            return returnPromise.promise
        }
    }
}

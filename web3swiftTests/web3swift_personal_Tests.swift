//
//  web3swift_personal_Tests.swift
//  web3swift
//
//  Created by bogdan on 15.10.2018.
//  Copyright © 2018 The Matter Inc. All rights reserved.
//

import XCTest
@testable import web3swift_iOS

class web3swift_personal_Tests: XCTestCase {

    let nodeUrl = URL(string:"http://0.0.0.0:8545")!
    let password = "123"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNewAddressUnlock() {
        
        let web3 = Web3.new(nodeUrl)! // require runing node on nodeUrl
        
        guard case .success(let address) = web3.personal.newAccount(password: password) else { return XCTFail() }
        
        guard case .success(let allAddresses) = web3.eth.getAccounts() else { return XCTFail() }
        
        XCTAssert(allAddresses.contains(address), "Failed to add new account to remote node")
        
        guard case .success(let res) = web3.personal.unlockAccount(account: address, password: password) else { return XCTFail() }
        
        XCTAssert(res, "Failed to unlock new account on remote node")
    }

}

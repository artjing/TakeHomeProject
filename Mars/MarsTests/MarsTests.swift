//
//  MarsTests.swift
//  MarsTests
//
//  Created by 董静 on 11/11/21.
//

import XCTest

@testable import Mars

class MarsTests: XCTestCase {
    
    var homeTest : MarsNewsHomeViewController!
    
    override func setUp() {
        super.setUp()
        homeTest = MarsNewsHomeViewController()
    }
    
    override func tearDown() {
        homeTest = nil
        super.tearDown()
    }
    
    func test_is_valid_swich() {
        homeTest.languageSwitch()
    }
}

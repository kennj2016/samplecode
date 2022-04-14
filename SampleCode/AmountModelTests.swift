//
//  AmountModelTests.swift
//  SampleCode-Unit-SampleCode
//
//  Created by KenNguyen 09/12/2021.
//

import XCTest
import AppShared

final class AmountModelTests: XCTestCase {
    func testAmountModel() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let leftAmount = AmountModel(amount: 100, currency: "SAR")
        let rightAmount = AmountModel(amount: 100, currency: "SAR")
        let nagetiveAmount = AmountModel(amount: -100, currency: "SAR")
        let formatterAR = AmountFormatter(decimal: 3, lang: "ar")
        let formatterEN = AmountFormatter(decimal: 2, lang: "en")
        
        XCTAssertEqual(leftAmount.asText(), "SAR 100.00", "")
        XCTAssertEqual((leftAmount + rightAmount).asText(), AmountModel(amount: 200, currency: "SAR").asText(), "")
        XCTAssertEqual((leftAmount - rightAmount).asText(), AmountModel(amount: 0, currency: "SAR").asText(), "")
        XCTAssertEqual((AmountModel.total(items: [leftAmount, rightAmount])).asText(), AmountModel(amount: 200, currency: "SAR").asText(), "")
        XCTAssertEqual(leftAmount.asText(formatter: formatterAR), "100.000 ر.س", "")
        XCTAssertEqual(nagetiveAmount.asText(formatter: formatterAR), "100.000- ر.س", "")
        XCTAssertEqual(nagetiveAmount.asText(formatter: formatterEN), "SAR -100.00", "")
        XCTAssertEqual(leftAmount.asText(formatter: formatterEN), "SAR 100.00", "")
    }
}

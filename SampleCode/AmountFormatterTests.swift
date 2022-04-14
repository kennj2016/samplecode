//
//  AmountFormatterTests.swift
//  SampleCode-Unit-SampleCode
//
//  Created by KenNguyen 09/12/2021.
//

import XCTest
import AppShared

final class AmountFormatterTests: XCTestCase {
    func testAmountFormatter() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        XCTAssertEqual(AmountFormatter(decimal: 3, lang: "en").format(amount: 100, currency: "SAR"), "SAR 100.000", "")
        XCTAssertEqual(AmountFormatter(decimal: 2, lang: "en").format(amount: 100, currency: "AED"), "AED 100.00", "")
        XCTAssertEqual(AmountFormatter(decimal: 10, lang: "en").format(amount: 100, currency: "KWD"), "KWD 100.0000000000", "")
        XCTAssertEqual(AmountFormatter(decimal: 1, lang: "ar").format(amount: 100, currency: "QAR"), "100.0 ر.ق", "")
        XCTAssertEqual(AmountFormatter(decimal: 3, lang: "en").format(amount: 100, currency: "BHD"), "BHD 100.000", "")
        
        XCTAssertEqual(AmountFormatter(decimal: 3, lang: "en").format(amount: -100, currency: "BHD"), "BHD -100.000", "")
        XCTAssertEqual(AmountFormatter(decimal: 3, lang: "ar").format(amount: -100, currency: "BHD"), "100.000- د.ب", "")
        XCTAssertEqual(AmountFormatter(decimal: 3, lang: "en").format(amount: 100.123456, currency: "SAR"), "SAR 100.123", "")
    }
}

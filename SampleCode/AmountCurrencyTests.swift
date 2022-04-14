//
//  AmountCurrencyTests.swift
//  AppService-Unit-AppServiceTests
//
//  Created by KenNguyen 09/12/2021.
//

import XCTest
import AppShared

final class AmountCurrencyTests: XCTestCase {
    func testAmountCurrency() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(AmountCurrency(currency: "SAR", lang: "en").format(), "SAR", "KSA english symbol")
        XCTAssertEqual(AmountCurrency(currency: "SAR", lang: "ar").format(), "ر.س", "KSA arabic symbol")
        XCTAssertEqual(AmountCurrency(currency: "AED", lang: "en").format(), "AED", "UAE english symbol")
        XCTAssertEqual(AmountCurrency(currency: "AED", lang: "ar").format(), "د.إ", "UAE arabic symbol")
        XCTAssertEqual(AmountCurrency(currency: "KWD", lang: "en").format(), "KWD", "KWI english symbol")
        XCTAssertEqual(AmountCurrency(currency: "KWD", lang: "ar").format(), "د.ك", "KWI arabic symbol")
        XCTAssertEqual(AmountCurrency(currency: "QAR", lang: "en").format(), "QAR", "QAR english symbol")
        XCTAssertEqual(AmountCurrency(currency: "QAR", lang: "ar").format(), "ر.ق", "QAR arabic symbol")
        XCTAssertEqual(AmountCurrency(currency: "BHD", lang: "en").format(), "BHD", "BHD english symbol")
        XCTAssertEqual(AmountCurrency(currency: "BHD", lang: "ar").format(), "د.ب", "BHD arabic symbol")
    }
}

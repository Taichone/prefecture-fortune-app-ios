//
//  DateTests.swift
//  PrefectureFortuneAppTests
//
//  Created by Taichi on 2024/06/07.
//

import XCTest
@testable import PrefectureFortuneApp

final class DateTests: XCTestCase {
    func testConvertToYearMonthDay_Date型の年月日を正しく変換できること() {
        // Arrange
        let year = 2024
        let month = 12
        let day = 31
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let date = Calendar.current.date(from: dateComponents)!

        // Act
        let yearMonthDay = date.convertToYearMonthDay()

        // Assert
        XCTAssertEqual(yearMonthDay.year, year)
        XCTAssertEqual(yearMonthDay.month, month)
        XCTAssertEqual(yearMonthDay.day, day)
    }
}

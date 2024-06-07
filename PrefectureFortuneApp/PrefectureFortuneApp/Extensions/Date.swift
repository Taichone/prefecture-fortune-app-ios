//
//  Date.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation

extension Date {
    func convertToYearMonthDay() -> YearMonthDay {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)

        return YearMonthDay(year: year, month: month, day: day)
    }
}

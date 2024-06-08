//
//  MonthDay.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/06.
//

import Foundation

struct MonthDay: Decodable {
    let month: Int
    let day: Int
}

extension MonthDay {
    func convertToString() -> String {
        return "\(self.month)/\(self.day)"
    }
}

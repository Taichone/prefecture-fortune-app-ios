//
//  User.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/06.
//

import Foundation

struct User: Encodable {
    let name: String
    let birthday: YearMonthDay
    let bloodType: Self.BloodType

    enum BloodType: String, CaseIterable, Encodable {
        case a
        case b
        case ab
        case o

        /// 血液型の大文字表記
        var displayName: String {
            self.rawValue.uppercased()
        }
    }
}

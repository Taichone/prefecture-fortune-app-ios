//
//  FortuneViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation
import SwiftData
import Combine

@Observable
final class FortuneViewModel {
    var name = ""
    var birthday = Date()
    var bloodType = User.BloodType.a

    func createUserFromInput() -> User {
        return User(
            name: self.name,
            birthday: self.birthday.convertToYearMonthDay(),
            bloodType: self.bloodType
        )
    }
}

extension FortuneViewModel {
    /// Fortune API の RequestBody.name 文字数上限
    static let maxNameLength = 127
}

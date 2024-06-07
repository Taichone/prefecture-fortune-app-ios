//
//  FortuneViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation

class FortuneViewModel: ObservableObject {
    @Published var name = ""
    @Published var birthday = Date()
    @Published var bloodType = User.BloodType.a
}

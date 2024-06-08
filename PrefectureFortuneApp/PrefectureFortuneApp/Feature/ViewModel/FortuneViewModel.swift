//
//  FortuneViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation

@MainActor
class FortuneViewModel: ObservableObject {
    @Published var name = ""
    @Published var birthday = Date()
    @Published var bloodType = User.BloodType.a
    @Published var fortuneResultViewIsLoading = true
    var resultPrefecture = Prefecture.placeholder
    let fortuneTeller: PrefectureFortuneTeller

    init(fortuneTeller: PrefectureFortuneTeller) {
        self.fortuneTeller = fortuneTeller
    }

    func onFortuneResultViewAppear() {
        Task {
            await self.fetchResultPrefecture()
            self.fortuneResultViewIsLoading = false
        }
    }

    private func fetchResultPrefecture() async {
        let user = User(name: self.name,
                        birthday: self.birthday.convertToYearMonthDay(),
                        bloodType: self.bloodType
        )
        let result = self.fortuneTeller.fetchFortuneResultPrefecture(from: user)
        self.resultPrefecture = result
    }
}

protocol PrefectureFortuneTeller {
    func fetchFortuneResultPrefecture(from: User) -> Prefecture
}

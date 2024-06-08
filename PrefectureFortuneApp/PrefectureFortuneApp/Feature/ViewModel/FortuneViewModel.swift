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
            self.fortuneResultViewIsLoading = true
            await self.fetchResultPrefecture()
            self.fortuneResultViewIsLoading = false
        }
    }

    private func fetchResultPrefecture() async {
        let user = User(name: self.name,
                        birthday: self.birthday.convertToYearMonthDay(),
                        bloodType: self.bloodType
        )

        do {
            let result = try await self.fortuneTeller.fetchFortuneResultPrefecture(from: user)
            self.resultPrefecture = result
        } catch {
            // TODO: FortuneView に戻る
            // アラートを表示して、OK 押させて FortuneView に戻す
            print(error)
        }
    }
}

protocol PrefectureFortuneTeller {
    func fetchFortuneResultPrefecture(from: User) async throws -> Prefecture
}

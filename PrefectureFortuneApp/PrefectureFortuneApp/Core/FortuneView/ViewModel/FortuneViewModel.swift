//
//  FortuneViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation
import Combine

@MainActor
class FortuneViewModel: ObservableObject {
    @Published var name = ""
    @Published var birthday = Date()
    @Published var bloodType = User.BloodType.a
    @Published var fortuneResultViewIsLoading = true
    var resultPrefecture = Prefecture()
    let fortuneTeller: PrefectureFortuneTeller
    let backNavigationTrigger = PassthroughSubject<Void, Never>()

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
        let user = User(
            name: self.name,
            birthday: self.birthday.convertToYearMonthDay(),
            bloodType: self.bloodType
        )

        do {
            let result = try await self.fortuneTeller.fetchFortuneResultPrefecture(from: user)
            self.resultPrefecture = result
        } catch {
            self.backNavigationTrigger.send() // FortuneView に戻す
            print(error)
        }
    }
}

extension FortuneViewModel {
    /// Fortune API の RequestBody.name 文字数上限
    static let maxNameLength = 127
}

protocol PrefectureFortuneTeller {
    func fetchFortuneResultPrefecture(from: User) async throws -> Prefecture
}

//
//  FortuneAPIClient.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation
import Alamofire

final class FortuneAPIClient {
    static let shared = FortuneAPIClient()

    private init() {}

    private struct RequestBody: Encodable {
        let name: String
        let birthday: YearMonthDay
        let blood_type: String
        let today: YearMonthDay
    }

    private struct ResponseBody: Decodable {
        let name: String
        let has_coast_line: Bool
        let citizen_day: MonthDay?
        let capital: String
        let logo_url: String
        let brief: String
    }
}

extension FortuneAPIClient: PrefectureFortuneTeller {
    func fetchFortuneResultPrefecture(from user: User) -> Prefecture {
        // TODO: API リクエスト
        return Prefecture.placeholder
    }
}

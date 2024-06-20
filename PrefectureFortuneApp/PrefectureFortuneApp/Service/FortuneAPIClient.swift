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

        func convertToPrefecture() -> Prefecture {
            return Prefecture(
                name: self.name,
                capital: self.capital,
                citizenMonth: self.citizen_day?.month,
                citizenDay: self.citizen_day?.day,
                hasCoastLine: self.has_coast_line,
                logoUrl: self.logo_url,
                brief: self.brief
            )
        }
    }
}

extension FortuneAPIClient: PrefectureProvider {
    func getPrefecture(from user: User) async throws -> Prefecture {
        let endPoint = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune"
        let headers: HTTPHeaders = ["API-Version": "v1"]
        let requestBody = Self.RequestBody(
            name: user.name,
            birthday: user.birthday,
            blood_type: user.bloodType.rawValue,
            today: YearMonthDay.today()
        )

        let response = try await AF.request(
            endPoint,
            method: .post,
            parameters: requestBody,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .serializingDecodable(ResponseBody.self).value

        return response.convertToPrefecture()
    }
}

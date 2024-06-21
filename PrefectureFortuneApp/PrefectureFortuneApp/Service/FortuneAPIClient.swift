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
        let bloodType: String
        let today: YearMonthDay
    }
}

extension FortuneAPIClient: PrefectureInfoProvider {
    func getPrefectureInfo(from user: User) async throws -> PrefectureInfo {
        let endPoint = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune"
        let headers: HTTPHeaders = ["API-Version": "v1"]
        let requestBody = Self.RequestBody(
            name: user.name,
            birthday: user.birthday,
            bloodType: user.bloodType.rawValue,
            today: YearMonthDay.today()
        )

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try await AF.request(
            endPoint,
            method: .post,
            parameters: requestBody,
            encoder: JSONParameterEncoder(encoder: encoder),
            headers: headers
        )
        .validate()
        .serializingDecodable(PrefectureInfo.self, decoder: decoder).value

        return response
    }
}

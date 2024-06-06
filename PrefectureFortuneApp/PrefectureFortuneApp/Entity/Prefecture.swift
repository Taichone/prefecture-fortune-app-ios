//
//  Prefecture.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/06.
//

import Foundation

struct Prefecture: Decodable {
    let name: String
    let capital: String
    let citizenDay: MonthDay?
    let hasCoastLine: Bool
    let logoUrl: String
    let brief: String
}

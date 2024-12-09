//
//  TimeZoneInfo.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//

import Foundation
struct TimeZoneInfo: Codable {

    let value: String
    let abbr: String
    let offset: Double
    let isdst: Bool
    let text: String
    let utc: [String]
}

//
//  TimeZoneManager.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//

import Foundation

class TimeZoneManager {

     func loadTimeZones() -> [TimeZoneInfo]? {
        guard let url = Bundle.main.url(forResource: "timezones", withExtension: "json") else {
            print("Error: JSON file not found.")
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: url)
            return decodeTimeZones(from: jsonData)
        } catch {
            print("Error loading JSON data: \(error)")
            return nil
        }
    }

    func decodeTimeZones(from jsonData: Data) -> [TimeZoneInfo]? {
        let decoder = JSONDecoder()

        do {
            let timeZoneInfoArray = try decoder.decode([TimeZoneInfo].self, from: jsonData)
            return timeZoneInfoArray
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

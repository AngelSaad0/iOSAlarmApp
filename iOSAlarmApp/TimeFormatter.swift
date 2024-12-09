//
//  TimeFormatter.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//

import Foundation

class TimeFormatter {
    static func formatTime(currentDate: Date, userOffset: Int, cityOffset: Double) -> String {
        let timeDifference = cityOffset - Double(userOffset)

        // Adjust the current date by the time difference
        guard let adjustedDate = Calendar.current.date(byAdding: .hour, value: Int(timeDifference), to: currentDate) else {
            return "Error"
        }

        // Format the adjusted date
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: adjustedDate)
    }
}


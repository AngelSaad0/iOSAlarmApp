//
//  CoreDataManager.swift
//  iOSAlarmApp
//
//  Created by Engy on 12/6/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}

    /// Save the context if there are changes
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    /// Save a TimeZoneItem to Core Data
    func saveTimeZoneItem(cityItem: TimeZoneInfo) {
        if !isTimeZoneIn(city: cityItem.text) {
            let timeZoneItem = TimeZoneItem(context: managedContext)
            timeZoneItem.value = cityItem.value
            timeZoneItem.abbr = cityItem.abbr
            timeZoneItem.offset = cityItem.offset
            timeZoneItem.isdst = cityItem.isdst
            timeZoneItem.text = cityItem.text
            timeZoneItem.utc = nil
            saveContext()
            print("Time zone saved successfully.")
        } else {
            print("Time zone already exists.")
        }
    }

    /// Delete a specific TimeZoneItem by city name
    func deleteItem(city: String) {
        let fetchRequest: NSFetchRequest<TimeZoneItem> = TimeZoneItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "text == %@", city)

        do {
            let results = try managedContext.fetch(fetchRequest)
            results.forEach { managedContext.delete($0) }
            saveContext()
            print("Time zone removed successfully.")
        } catch {
            print("Error removing time zone: \(error)")
        }
    }

    /// Fetch all TimeZoneItems from Core Data
    func fetchItems() -> [TimeZoneInfo] {
        let fetchRequest: NSFetchRequest<TimeZoneItem> = TimeZoneItem.fetchRequest()

        do {
            let results = try managedContext.fetch(fetchRequest)
            return mapToTimeZoneInfo(items: results)
        } catch {
            print("Error fetching time zones: \(error)")
            return []
        }
    }

    /// Map Core Data `TimeZoneItem` entities to `TimeZoneInfo` models
    private func mapToTimeZoneInfo(items: [TimeZoneItem]) -> [TimeZoneInfo] {
        return items.map { item in
            TimeZoneInfo(
                value: item.value ?? "",
                abbr: item.abbr ?? "",
                offset: item.offset,
                isdst: item.isdst,
                text: item.text ?? "",
                utc: []
            )
        }
    }

    /// Check if a TimeZoneItem exists in Core Data by city name
    func isTimeZoneIn(city: String) -> Bool {
        let fetchRequest: NSFetchRequest<TimeZoneItem> = TimeZoneItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "text == %@", city)

        do {
            return try managedContext.count(for: fetchRequest) > 0
        } catch {
            print("Error checking time zone existence: \(error)")
            return false
        }
    }
}

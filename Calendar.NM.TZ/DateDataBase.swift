//
//  DateDataBase.swift
//  Calendar.NM.TZ
//
//  Created by Александр Гужавин on 25.07.2023.
//

import Foundation

struct Event {
    let title: String
    let date: DateComponents
}


final class DateDataBase {
    
    public static let shared: DateDataBase = DateDataBase()
    
    let semaphore = DispatchSemaphore(value: 1)
    
    private var selectedDates: [Event] = []
    
    var dateComponents: [DateComponents] { get { return selectedDates.map { $0.date } } }
    
    
    func add(event: Event) {
        semaphore.wait()
        selectedDates.append(event)
        semaphore.signal()
    }
    
    func filter(date: DateComponents) -> [Event] {
        return selectedDates.filter {
            $0.date.year == date.year &&
            $0.date.month == date.month &&
            $0.date.day == date.day
        }
    }
    
    func contains(date: DateComponents) -> Bool {
        return selectedDates.contains { $0.date.year == date.year && $0.date.month == date.month && $0.date.day == date.day }
    }
}

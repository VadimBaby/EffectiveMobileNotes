//
//  DateFormatters.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 01.02.2025.
//

import Foundation

struct DateFormatters {
    static var dayMonthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }
}

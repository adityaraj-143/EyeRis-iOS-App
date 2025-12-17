//
//  general.swift
//  EyeRis
//
//  Created by SDC-USER on 17/12/25.
//

import Foundation

extension Date {
    var startOfWeek: Date {
        Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.yearForWeekOfYear, .weekOfYear],
                from: self
            )
        )!
    }
}

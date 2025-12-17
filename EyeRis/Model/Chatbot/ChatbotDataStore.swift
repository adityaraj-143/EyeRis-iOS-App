//
//  ChatbotDataStore.swift
//  EyeRis
//
//  Created by SDC-USER on 16/12/25.
//

import Foundation

struct ChatbotDataStore {

    static let calendar = Calendar.current

    static func makeTime(
        year: Int,
        month: Int,
        day: Int,
        hour: Int,
        minute: Int
    ) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components) ?? Date()
    }

    static let dummyMessages: [Message] = [

        Message(
            role: Role.bot,
            text: "Hi! 👋 I’m your eye-health assistant. How can I help you today?",
            time: makeTime(year: 2025, month: 5, day: 8, hour: 10, minute: 0),
            isBookmarked: false
        ),

        Message(
            role: Role.user,
            text: "I want to check my near vision.",
            time: makeTime(year: 2025, month: 5, day: 8, hour: 10, minute: 1),
            isBookmarked: false
        ),

        Message(
            role: Role.bot,
            text: "Sure! Before we start, make sure your phone is about 40 cm away from your eyes.",
            time: makeTime(year: 2025, month: 5, day: 8, hour: 10, minute: 1),
            isBookmarked: true
        ),

        Message(
            role: Role.bot,
            text: "Please cover your right eye. Let me know when you’re ready.",
            time: makeTime(year: 2025, month: 5, day: 8, hour: 10, minute: 2),
            isBookmarked: false
        ),

        Message(
            role: Role.user,
            text: "Okay, ready.",
            time: makeTime(year: 2025, month: 5, day: 8, hour: 10, minute: 2),
            isBookmarked: false
        ),

        Message(
            role: Role.bot,
            text: "Great! Read out the letters you see on the screen.",
            time: makeTime(year: 2025, month: 5, day: 8, hour: 10, minute: 3),
            isBookmarked: false
        )
    ]
}

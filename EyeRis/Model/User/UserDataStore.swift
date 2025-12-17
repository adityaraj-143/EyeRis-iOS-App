//
//  UserDataStore.swift
//  EyeRis
//
//  Created by SDC-USER on 17/12/25.
//

import Foundation


final class UserDataStore {

    static let shared = UserDataStore()
    private init() {}

    // MARK: - Stored User (DEFAULT VALUES)
    private(set) var currentUser: User = User(
        firstName: "Christopher",
        lastName: "Paul",
        gender: "Male",
        dob: Date(), // today by default
        eyeHealthData: UserEyeHealthData(
            condition: [.dryEyes] // empty → "None"
        )
    )

    // MARK: - Update APIs

    func updateFirstName(_ name: String) {
        currentUser.firstName = name
    }

    func updateLastName(_ name: String) {
        currentUser.lastName = name
    }

    func updateGender(_ gender: String) {
        currentUser.gender = gender
    }

    func updateDOB(_ date: Date) {
        currentUser.dob = date
    }

    func updateEyeConditions(_ conditions: [Conditions]) {
        currentUser.eyeHealthData.condition = conditions
    }

    // MARK: - Read helpers

    var primaryEyeCondition: String {
        currentUser.eyeHealthData.primaryConditionText
    }
}

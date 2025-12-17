//
//  ExerciseMockDataStore.swift
//  EyeRis
//
//  Created by SDC-USER on 12/12/25.
//

import Foundation
//MARK: EXERCISE HISTORY
// Dummy data for Exercise History

let mockPerformedExerciseStats: [PerformedExerciseStat] = [
    // Today (2 exercises → 90+ avg)
    PerformedExerciseStat(id: 1, name: "Eye Focus Drill", performedOn: Date(), accuracy: 94, speed: 91),
    PerformedExerciseStat(id: 2, name: "Blink Control", performedOn: Date(), accuracy: 92, speed: 90),

    // 2 days ago (3 exercises → 80+ avg)
    PerformedExerciseStat(id: 3, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -2*24*60*60), accuracy: 86, speed: 82),
    PerformedExerciseStat(id: 4, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -2*24*60*60), accuracy: 84, speed: 80),
    PerformedExerciseStat(id: 5, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -2*24*60*60), accuracy: 85, speed: 81),

    // 4 days ago (1 exercise → <75)
    PerformedExerciseStat(id: 6, name: "Color Recognition", performedOn: Date(timeIntervalSinceNow: -4*24*60*60), accuracy: 73, speed: 70),

    // 7 days ago (4 exercises → 80+ avg)
    PerformedExerciseStat(id: 7, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 88, speed: 84),
    PerformedExerciseStat(id: 8, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 85, speed: 82),
    PerformedExerciseStat(id: 9, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 86, speed: 83),
    PerformedExerciseStat(id: 10, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -7*24*60*60), accuracy: 84, speed: 81),

    // 9 days ago (2 exercises → <75 avg)
    PerformedExerciseStat(id: 11, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -9*24*60*60), accuracy: 74, speed: 71),
    PerformedExerciseStat(id: 12, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -9*24*60*60), accuracy: 72, speed: 69),


    // 14 days ago (5 exercises → 90+ avg)
    PerformedExerciseStat(id: 13, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 93, speed: 91),
    PerformedExerciseStat(id: 14, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 92, speed: 90),
    PerformedExerciseStat(id: 15, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 94, speed: 92),
    PerformedExerciseStat(id: 16, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 91, speed: 89),
    PerformedExerciseStat(id: 17, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -14*24*60*60), accuracy: 93, speed: 90),

    // 16 days ago (1 exercise → 80+)
    PerformedExerciseStat(id: 18, name: "Color Recognition", performedOn: Date(timeIntervalSinceNow: -16*24*60*60), accuracy: 82, speed: 79),

    // 21 days ago (6 exercises → <75 avg)
    PerformedExerciseStat(id: 19, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 74, speed: 70),
    PerformedExerciseStat(id: 20, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 73, speed: 69),
    PerformedExerciseStat(id: 21, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 72, speed: 68),
    PerformedExerciseStat(id: 22, name: "Near-Far Focus", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 71, speed: 67),
    PerformedExerciseStat(id: 23, name: "Eye Tracking", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 73, speed: 69),
    PerformedExerciseStat(id: 24, name: "Color Recognition", performedOn: Date(timeIntervalSinceNow: -21*24*60*60), accuracy: 72, speed: 68),

    // 23 days ago (3 exercises → 80+ avg)
    PerformedExerciseStat(id: 25, name: "Eye Focus Drill", performedOn: Date(timeIntervalSinceNow: -23*24*60*60), accuracy: 85, speed: 82),
    PerformedExerciseStat(id: 26, name: "Blink Control", performedOn: Date(timeIntervalSinceNow: -23*24*60*60), accuracy: 87, speed: 83),
    PerformedExerciseStat(id: 27, name: "Peripheral Vision", performedOn: Date(timeIntervalSinceNow: -23*24*60*60), accuracy: 84, speed: 81)
]

class ExerciseData {
    
    // MARK: - All Exercises (Complete Library)
    
    static let allExercises: [Exercise] = [
        // Exercise 1: Focus Shifting
        Exercise(
            id: 1,
            name: "Focus Shifting",
            duration: 40,
            instructions: ExerciseInstruction(
                title: "Focus Shifting",
                description: [
                    "Among all the white objects follow the red object on the screen.",
                    "Focus on the red object, when it changes shift your focus to the changed one.",
                    "Try to do this feeling continuous without any break.",
                    "Try to do the focus shifting accurately, and keep up with the speed."
                ],
                video: "focus_shifting_demo"
            ),
            targetedConditions: [.blurredVision, .eyeFatigue]
        ),
        
        // Exercise 2: Figure-8
        Exercise(
            id: 2,
            name: "Figure-8",
            duration: 60,
            instructions: ExerciseInstruction(
                title: "Figure-8",
                description: [
                    "Track a moving dot following a figure-8 pattern on screen.",
                    "Follow the object on the screen within the given area.",
                    "Try to keep up with the speed, do not over-speed.",
                    "Try to keep the object in the center of your vision at all times."
                ],
                video: "figure_8_demo"
            ),
            targetedConditions: [.blurredVision]
        ),
        
        // Exercise 3: Smooth Pursuit
        Exercise(
            id: 3,
            name: "Smooth Pursuit",
            duration: 30,
            instructions: ExerciseInstruction(
                title: "Smooth Pursuit",
                description: [
                    "Smoothly follow a moving target across the screen.",
                    "Keep your eyes on the target without jerky movements.",
                    "Move your eyes smoothly like they're following honey dripping.",
                    "Try to predict the target's movement pattern."
                ],
                video: "smooth_pursuit_demo"
            ),
            targetedConditions: [.eyeFatigue]
        ),
        
        // Exercise 4: Light Adaptation
        Exercise(
            id: 4,
            name: "Light Adaptation",
            duration: 45,
            instructions: ExerciseInstruction(
                title: "Light Adaptation",
                description: [
                    "Adapt your eyes to changing light conditions on screen.",
                    "Watch as the screen brightness changes gradually.",
                    "Don't look away, keep your eyes on the center point.",
                    "Blink naturally as needed, don't force your eyes open."
                ],
                video: "light_adaptation_demo"
            ),
            targetedConditions: [.dryEyes, .blurredVision]
        ),
        
        // Exercise 5: Saccadic Movement
        Exercise(
            id: 5,
            name: "Saccadic Movement",
            duration: 50,
            instructions: ExerciseInstruction(
                title: "Saccadic Movement",
                description: [
                    "Jump your eyes between multiple targets quickly and accurately.",
                    "Move your eyes from one target to another as fast as possible.",
                    "Try to land exactly on each new target.",
                    "Keep your head still, only move your eyes."
                ],
                video: "saccadic_movement_demo"
            ),
            targetedConditions: [.eyeFatigue]
        ),
        
        // Exercise 6: Guided Blinking
        Exercise(
            id: 6,
            name: "Guided Blinking",
            duration: 25,
            instructions: ExerciseInstruction(
                title: "Guided Blinking",
                description: [
                    "Blink your eyes in a controlled, guided pattern.",
                    "Blink at the rhythm shown on screen.",
                    "Keep your eyes lubricated by blinking fully.",
                    "This helps reduce eye strain from screen time."
                ],
                video: "guided_blinking_demo"
            ),
            targetedConditions: [.dryEyes, .eyeFatigue]
        ),
        
        // Exercise 7: Eye Rolling
        Exercise(
            id: 7,
            name: "Eye Rolling",
            duration: 35,
            instructions: ExerciseInstruction(
                title: "Eye Rolling",
                description: [
                    "Roll your eyes in circular motions in both directions.",
                    "Move your eyes slowly in a circular motion.",
                    "Complete the circle without jerking or jumping.",
                    "Alternate between clockwise and counter-clockwise."
                ],
                video: "eye_rolling_demo"
            ),
            targetedConditions: [.eyeFatigue]
        ),
        
        // Exercise 8: Color Contrast
        Exercise(
            id: 8,
            name: "Color Contrast",
            duration: 55,
            instructions: ExerciseInstruction(
                title: "Color Contrast",
                description: [
                    "Distinguish between objects of different color contrasts.",
                    "Focus on identifying color differences quickly.",
                    "Track the colored objects as they move.",
                    "Try to maintain focus on the moving targets."
                ],
                video: "color_contrast_demo"
            ),
            targetedConditions: [.blurredVision]
        ),
        
        // Exercise 9: Fun Movement Tracking
        Exercise(
            id: 9,
            name: "Fun Movement Tracking",
            duration: 40,
            instructions: ExerciseInstruction(
                title: "Fun Movement Tracking",
                description: [
                    "Track fun animated characters moving across the screen.",
                    "Keep your eyes on the character throughout the exercise.",
                    "Don't let your eyes lose focus even if movement speeds up.",
                    "This is a fun way to strengthen your eye muscles."
                ],
                video: "fun_movement_demo"
            ),
            targetedConditions: [.blurredVision]
        ),
        
        // Exercise 10: Near-Far Focus
        Exercise(
            id: 10,
            name: "Near-Far Focus",
            duration: 45,
            instructions: ExerciseInstruction(
                title: "Near-Far Focus",
                description: [
                    "Alternate your focus between near and far objects.",
                    "Focus on a close object, then shift to a distant object.",
                    "Do this alternation at the pace shown.",
                    "This strengthens your eye's accommodation ability."
                ],
                video: "near_far_focus_demo"
            ),
            targetedConditions: [.blurredVision, .eyeFatigue]
        ),
        
        // Exercise 11: Peripheral Vision
        Exercise(
            id: 11,
            name: "Peripheral Vision",
            duration: 40,
            instructions: ExerciseInstruction(
                title: "Peripheral Vision",
                description: [
                    "Train your peripheral vision by tracking side movements.",
                    "Keep your eyes forward while following objects in your side vision.",
                    "Don't turn your head, only move your eyes.",
                    "This expands your field of awareness."
                ],
                video: "peripheral_vision_demo"
            ),
            targetedConditions: [.eyeFatigue]
        ),
        
        // Exercise 12: Depth Perception
        Exercise(
            id: 12,
            name: "Depth Perception",
            duration: 50,
            instructions: ExerciseInstruction(
                title: "Depth Perception",
                description: [
                    "Improve your ability to perceive depth through 3D movements.",
                    "Follow the 3D object as it moves in space.",
                    "Try to estimate how far or close it is from you.",
                    "This helps with your spatial awareness."
                ],
                video: "depth_perception_demo"
            ),
            targetedConditions: [.blurredVision, .eyeFatigue]
        )
    ]
    
    // MARK: function to get recommended exercises
    static func getRecommendedExercises(for user: User) -> [Exercise] {
        return allExercises.filter { exercise in
            exercise.isRecommended(for: user)
        }
    }
}

class ExerciseFetcher {
    
    // MARK: - Get Recommended Exercises
    
    /// Fetches exercises recommended for a specific user based on their eye conditions
    /// - Parameter user: The User object containing eye health data
    /// - Returns: Array of Exercise objects that match user's conditions
    static func getRecommendedExercises(for user: User) -> [Exercise] {
        return ExerciseData.getRecommendedExercises(for: user)
    }
    
    // MARK: - Get All Exercises
    
    /// Fetches all available exercises in the library
    /// - Returns: Complete array of all Exercise objects
    static func getAllExercises() -> [Exercise] {
        return ExerciseData.allExercises
    }
    
    // MARK: - Get Exercise by ID
    
    /// Fetches a single exercise by its ID
    /// - Parameter id: The unique identifier of the exercise (Int)
    /// - Returns: The Exercise object if found, nil if not found
    static func getExerciseByID(_ id: Int) -> Exercise? {
        return ExerciseData.allExercises.first { exercise in
            exercise.id == id
        }
    }
    
    // MARK: - Get Exercise Table Data
    
    /// Converts an array of Exercise objects into simplified data for table display
    /// - Parameter exercises: Array of Exercise objects
    /// - Returns: Array of tuples containing (name, duration) pairs
    static func getExerciseTableData(exercises: [Exercise]) -> [(name: String, duration: String)] {
        return exercises.map { exercise in
            let durationString: String
            if exercise.duration >= 60 {
                let minutes = exercise.duration / 60
                durationString = "\(minutes) min"
            } else {
                durationString = "\(exercise.duration) sec"
            }
            
            return (name: exercise.name, duration: durationString)
        }
    }
    
    // MARK: - Get Exercise Instructions
    
    /// Fetches all instruction-related data for an exercise
    /// - Parameter exerciseID: The unique identifier of the exercise
    /// - Returns: The ExerciseInstruction if exercise is found, nil otherwise
    static func getExerciseInstructions(exerciseID: Int) -> ExerciseInstruction? {
        guard let exercise = getExerciseByID(exerciseID) else {
            return nil
        }
        return exercise.instructions
    }
    
    // MARK: - Get Exercise Info
    
    /// Fetches basic info about an exercise for display in lists
    /// - Parameter exerciseID: The unique identifier of the exercise
    /// - Returns: Dictionary with name, duration, difficulty, or nil if not found
    static func getExerciseInfo(exerciseID: Int) -> [String: Any]? {
        guard let exercise = getExerciseByID(exerciseID) else {
            return nil
        }
        
        let durationString: String
        if exercise.duration >= 60 {
            let minutes = exercise.duration / 60
            durationString = "\(minutes) min"
        } else {
            durationString = "\(exercise.duration) sec"
        }
        
        return [
            "name": exercise.name,
            "duration": durationString
        ]
    }
}

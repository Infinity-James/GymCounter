//
//  Exercise.swift
//  GymCounter
//
//  Created by James Valaitis on 05/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Exercise Struct

/**
    `Exercise`
 
    Represents an exercise performed by the user.
 */
public struct Exercise {
    
    //	MARK: Properties
    
    /// The current sets performed for this exercise.
    var sets: [Set]
    /// The name of the exercise.
    let name: String
    /// The target number of reps for each set performed.
    let repTarget: Int?
}

//	MARK: Set Struct

/**
    `Set`
 
    Represents a set of an exercise.
 */
struct Set {
    
    //	MARK: Properties
    
    /// The number of reps performed in the set.
    let reps: Int
    /// The weight lifted in this set.
    let weight: Double
    /// The measurement unit used for the weight lifted.
    let weightMeasurementUnit: MeasurementUnit
}

//	MARK: Measurement Unit Enum

/**
    `MeasurementUnit`
 
    The unit of measurement.
 */
enum MeasurementUnit {
    /// An imperial measurement unit (lbs).
    case imperial
    /// A metric measurement unit (kg).
    case metric
    
    /// This measurement unit as a unit to meaure mass (as a String).
    var massUnitString: String {
        switch self {
        case .imperial:
            return "lbs"
        case .metric:
            return "kg"
        }
    }
}

//
//  Exercise.swift
//  GymCounter
//
//  Created by James Valaitis on 05/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Exercise Struct

struct Exercise {
    
    //	MARK: Properties
    
    /// The current sets performed for this exercise.
    var sets: [Set]
    /// The name of the exercise.
    let name: String
    /// The target number of reps for each set performed.
    let repTarget: Int?
}

//	MARK: Set Struct

struct Set {
    
    //	MARK: Measurement Unit Enum
    
    enum MeasurementUnit {
        /// An imperial measurement unit (lbs).
        case Imperial
        /// A metric measurement unit (kg).
        case Metric
        
        /// This measurement unit as a unit to meaure mass (as a String).
        var massUnitString: String {
            switch self {
            case .Imperial:
                return "lbs"
            case .Metric:
                return "kg"
            }
        }
    }
    
    //	MARK: Properties
    
    /// The number of reps performed in the set.
    let reps: Int
    /// The weight lifted in this set.
    let weight: Double
    /// The measurement unit used for the weight lifted.
    let weightMeasurementUnit: MeasurementUnit
}
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
    
    //	MARK: Properties
    
    /// The number of reps performed in the set.
    let reps: Int
}
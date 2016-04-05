//
//  ExerciseCounterViewController.swift
//  GymCounter
//
//  Created by James Valaitis on 05/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Exercise Counter View Controller Class

class ExerciseCounterViewController: UIViewController {
    
    //	MARK: Properties
    
    /// The exercise that htis view controller is counting sets and reps for.
    var exercise: Exercise? {
        didSet {
            if let exercise = exercise where isViewLoaded() {
                configureUIWithExercise(exercise)
            }
        }
    }
    /// The label that defines how many reps were performed in the set.
    @IBOutlet var repsLabel: UILabel!
    
    //	MARK: UI Functions
    
    private func configureUIWithExercise(exercise: Exercise) {
        if let targetReps = exercise.repTarget {
            repsLabel.text = "\(targetReps)"
        }
    }
    
    //	MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exercise = exercise {
            configureUIWithExercise(exercise)
        }
    }
}
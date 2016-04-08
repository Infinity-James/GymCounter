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
    @IBOutlet private var repsLabel: UILabel!
    /// The counter used to increment or decrement the reps for a set.
    @IBOutlet private var repsCounter: UIStepper!
    /// Button to set the unit of measurement for the mass lifted.
    @IBOutlet private var unitButton: MassUnitButton!
    /// The text field which provides the user with a way to enter the mass lifted.
    @IBOutlet private var weightTextField: UITextField!
    
    //	MARK: Actions
    
    @IBAction private func counterValueChanged(counter: UIStepper) {
        repsLabel.text = "\(Int(counter.value))"
    }
    
    @IBAction private func addSetTapped(addButton: UIButton) {
        guard let reps = Int(repsLabel.text ?? ""),
        weight =  Double(weightTextField.text ?? "") else {
            let repsErrorMessage = "The reps label should only ever display a number and should be convertible to Int: \(repsLabel.text)"
            let weightErrorMessage = "The weight text field should only ever contain a number: \(weightTextField.text)"
            let fullErrorMessage = repsErrorMessage + "\n" + weightErrorMessage
            fatalError(fullErrorMessage)
        }
        
        let set = Set(reps: reps, weight: weight, weightMeasurementUnit: unitButton.selectedMeasurementUnit)
        exercise?.sets.append(set)
        
    }
    
    //	MARK: UI Functions
    
    private func configureUIWithExercise(exercise: Exercise) {
        if let targetReps = exercise.repTarget {
            repsLabel.text = "\(targetReps)"
            repsCounter.value = Double(targetReps)
        }
        
        title = exercise.name
    }
    
    //	MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exercise = exercise {
            configureUIWithExercise(exercise)
        }
    }
}
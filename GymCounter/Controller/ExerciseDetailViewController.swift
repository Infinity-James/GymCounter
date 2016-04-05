//
//  ExerciseDetailViewController.swift
//  GymCounter
//
//  Created by James Valaitis on 05/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit
import UIKitClosures

//	MARK: Exercise Detail View Controller Class

class ExerciseDetailViewController: UIViewController {
    
    //	MARK: Constants
    
    private let startExerciseSegueIdentifier = "StartExerciseSegue"
    
    //	MARK: Properties
    
    /// Field for user to enter name of exercise.
    @IBOutlet var nameTextField: UITextField!
    /// Field for user to enter target number of sets.
    @IBOutlet var setsTextField: UITextField!
    /// Field for user to enter target number of reps for each set.
    @IBOutlet var targetRepsTextField: UITextField!
    
    //	MARK: Actions
    
    @IBAction private func startExerciseTapped(startButton: UIButton) {
        
        guard let exerciseName = nameTextField.text else {
            let alert = UIAlertController(title: "Missing Information", message: "You have not entered a name for the exercise", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
            alert.addAction(okayAction)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let repsTarget = Int(targetRepsTextField.text ?? "")
        
        let exercise = Exercise(sets: [], name: exerciseName, repTarget: repsTarget)

        guard let exerciseCounterVC = storyboard?.instantiateViewControllerWithIdentifier(String(ExerciseCounterViewController)) as? ExerciseCounterViewController else {
            fatalError("Storyboard should contain view controller with identifier: \(String(ExerciseCounterViewController))")
        }
        
        exerciseCounterVC.exercise = exercise
        navigationController?.pushViewController(exerciseCounterVC, animated: true)
    }
}
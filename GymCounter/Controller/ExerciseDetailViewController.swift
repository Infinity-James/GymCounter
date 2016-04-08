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
    @IBOutlet private var nameTextField: UITextField!
    /// Field for user to enter target number of sets.
    @IBOutlet private var setsTextField: UITextField!
    /// Field for user to enter target number of reps for each set.
    @IBOutlet private var targetRepsTextField: UITextField!
    /// Field for user to enter weight for the sets.
    @IBOutlet private var weightTextField: UITextField!
    
    /// A button which when tapped allows the user to select the measurement unit for the weight.
    @IBOutlet private var massUnitButton: MassUnitButton!
    
    /// The stack view that holds the elements necessary to describe an exercise.
    @IBOutlet private var exerciseFormStackView: UIStackView!

    
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
    
    //	MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        massUnitButton.unitButtonDelegate = self
    }
}

//	MARK: MassUnitButtonDelegate

extension ExerciseDetailViewController: MassUnitButtonDelegate {

    func massUnitButton(unitButton: MassUnitButton, shouldDismissPickerView pickerView: UIPickerView) {
        exerciseFormStackView.removeArrangedSubview(pickerView)
        pickerView.removeFromSuperview()
    }

    
    func massUnitButton(unitButton: MassUnitButton, shouldDisplayPickerView pickerView: UIPickerView) {
        
        //  insert the picker into the stack view
        guard let parentView = unitButton.superview,
            parentViewIndex = exerciseFormStackView.arrangedSubviews.indexOf(parentView) else {
                fatalError("The button (\(unitButton)) should have a super view which is inside of the stack view: \(exerciseFormStackView).")
        }
        
        exerciseFormStackView.insertArrangedSubview(pickerView, atIndex: parentViewIndex + 1)
    }
}
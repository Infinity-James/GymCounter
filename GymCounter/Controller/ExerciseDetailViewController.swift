//
//  ExerciseDetailViewController.swift
//  GymCounter
//
//  Created by James Valaitis on 05/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Exercise Detail View Controller Class

/**
    `ExerciseDetailViewController`
 
    Displays a detail view for an exercise.
    
    The user can edit the details of an exercise:
    - Exercise name.
    - Target number of sets.
    - Target number of reps for each set.
    - The weight that the exercise will start with.
    - The mass unit measurement for the weight.
 */
class ExerciseDetailViewController: UIViewController {
    
    //	MARK: Constants
    
    /// Identifies a segue that is triggered when the user wants to start counting the exercise.
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
        
        guard let exerciseName = nameTextField.text,
			let weightText = weightTextField.text,
			let weight = Double(weightText), exerciseName != "" else {
				let alert = UIAlertController(title: "Missing Information", message: "Make sure there is a valid exercise name and weight entered before tyring to continue.", preferredStyle: .alert)
				let okayAction = UIAlertAction(title: "Got It", style: .cancel, handler: nil)
            alert.addAction(okayAction)
				present(alert, animated: true, completion: nil)
            return
        }
        
        let repsTarget = Int(targetRepsTextField.text ?? "")
        
        let exercise = Exercise(sets: [], name: exerciseName, repTarget: repsTarget)

		guard let exerciseCounterVC = storyboard?.instantiateViewController(withIdentifier: String(describing: ExerciseCounterViewController())) as? ExerciseCounterViewController else {
			fatalError("Storyboard should contain view controller with identifier: \(String(describing: ExerciseCounterViewController()))")
        }
        
        exerciseCounterVC.exercise = exercise
        exerciseCounterVC.weight = weight
        exerciseCounterVC.measurementUnit = massUnitButton.selectedMeasurementUnit
        navigationController?.pushViewController(exerciseCounterVC, animated: true)
    }
    
    @IBAction private func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    //	MARK: Keyboard Management
    
    private func dismissKeyboard() {
        nameTextField.resignFirstResponder()
        setsTextField.resignFirstResponder()
        targetRepsTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()

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
        
        //  insert the picker into the stack view below the button
        guard let parentView = unitButton.superview,
            let parentViewIndex = exerciseFormStackView.arrangedSubviews.indexOf(parentView) else {
                fatalError("The button (\(unitButton)) should have a super view which is inside of the stack view: \(exerciseFormStackView).")
        }
        
        dismissKeyboard()
        exerciseFormStackView.insertArrangedSubview(pickerView, atIndex: parentViewIndex + 1)
    }
}

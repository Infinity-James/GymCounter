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
    @IBOutlet private var measurementUnitButton: UIButton!
    
    /// The stack view that holds the elements necessary to describe an exercise.
    @IBOutlet private var exerciseFormStackView: UIStackView!
    
    /// The measurement units available to the user.
    private let measurementUnits: [Set.MeasurementUnit] = [.Metric, .Imperial]
    
    /// The picker view that allows the user to choose the measurement unit for the weight.
    private var unitPickerView: UIPickerView?
    
    //	MARK: Actions
    
    @IBAction private func measurementUnitButtonTapped(unitButton: UIButton) {
        
        if let unitPickerView = unitPickerView {
            exerciseFormStackView.removeArrangedSubview(unitPickerView)
            self.unitPickerView = nil
            return
        }
        
        //  create a way for the user to select the measurement unit
        unitPickerView = UIPickerView()
        unitPickerView!.dataSource = self
        unitPickerView!.delegate = self
        
        //  insert the picker into the stack view
        guard let parentView = unitButton.superview,
            parentViewIndex = exerciseFormStackView.arrangedSubviews.indexOf(parentView) else {
            fatalError("The button (\(unitButton)) should have a super view which is inside of the stack view: \(exerciseFormStackView).")
        }
        
        exerciseFormStackView.insertArrangedSubview(unitPickerView!, atIndex: parentViewIndex + 1)
    }
    
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

//	MARK: UIPickerViewDataSource

extension ExerciseDetailViewController: UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return measurementUnits.count
    }
}

//	MARK: UIPickerViewDelegate

extension ExerciseDetailViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let measurementUnit = measurementUnits[row]
        return measurementUnit.massUnitString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let measurementUnit = measurementUnits[row]
        measurementUnitButton.setTitle(measurementUnit.massUnitString, forState: .Normal)
    }
}
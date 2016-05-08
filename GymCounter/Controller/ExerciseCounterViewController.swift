//
//  ExerciseCounterViewController.swift
//  GymCounter
//
//  Created by James Valaitis on 05/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Exercise Counter View Controller Class

/**
    `ExerciseCounterViewController`
 
    This is where the user will count their sets and reps for an exercise.
 */
class ExerciseCounterViewController: UIViewController {
    
    //	MARK: Properties
    
    /// The data source for the sets collection view.
    private let setsDataSource = SetsCollectionViewDataSource()
    /// The delegate for the sets collection view.
    private let setsDelegate = SetsCollectionViewDelegate()
    
    /// The exercise that this view controller is counting sets and reps for.
    var exercise: Exercise? {
        didSet {
            if let exercise = exercise where isViewLoaded() {
                configureUIWithExercise(exercise)
            }
        }
    }
    /// The internal storage for the weight if text field isn't displayed yet.
    private var _weight: Double = 0.0
    /// The weight for the next set.
    var weight: Double? {
        get {
            return Double(weightTextField.text ?? "")
        }
        set {
            if let weightTextField = weightTextField {
                weightTextField.text = String(newValue ?? 0.0)
            } else if let weight = newValue {
                _weight = weight
            }
        }
    }
    /// The unit of measurement for the weight
    var measurementUnit: MeasurementUnit = .Metric {
        didSet {
            if let unitButton = unitButton {
                unitButton.selectedMeasurementUnit = measurementUnit
            }
        }
    }
    /// The label that defines how many reps were performed in the set.
    @IBOutlet private var repsLabel: UILabel!
    /// The counter used to increment or decrement the reps for a set.
    @IBOutlet private var repsCounter: UIStepper!
    /// Button to set the unit of measurement for the mass lifted.
    @IBOutlet private var unitButton: MassUnitButton! {
        didSet {
            unitButton.selectedMeasurementUnit = measurementUnit
            unitButton.unitButtonDelegate = self
        }
    }
    /// The text field which provides the user with a way to enter the mass lifted.
    @IBOutlet private var weightTextField: UITextField! {
        didSet {
            weightTextField.text = String(_weight)
        }
    }
    /// The collection view which will display the sets of this exercise.
    @IBOutlet private var setsCollectionView: UICollectionView! {
        didSet {
            setsDataSource.collectionView = setsCollectionView
            setsCollectionView.dataSource = setsDataSource
            setsCollectionView.delegate = setsDelegate
        }
    }
    
    /// The constraint between the weight text field and the add set label.
    @IBOutlet private var weightSetConstraint: NSLayoutConstraint!
    
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
        
        dismissKeyboard()
        unitButton.dismissPickerView()
        
        let set = Set(reps: reps, weight: weight, weightMeasurementUnit: unitButton.selectedMeasurementUnit)
        exercise?.sets.append(set)
    }
    
    @IBAction private func viewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    @objc @IBAction private func saveExercise(saveButtonItem: UIBarButtonItem) {
        
    }
    
    //	MARK: UI Functions
    
    private func configureUIWithExercise(exercise: Exercise) {
        if let targetReps = exercise.repTarget where exercise.sets.count == 0 {
            repsLabel.text = "\(targetReps)"
            repsCounter.value = Double(targetReps)
        }
        
        title = exercise.name
        
        setsDataSource.exercise = exercise
    }
    
    private func dismissKeyboard() {
        weightTextField.resignFirstResponder()
    }
    
    //	MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exercise = exercise {
            configureUIWithExercise(exercise)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(ExerciseCounterViewController.saveExercise(_:)))
    }
}

//	MARK: MassUnitButtonDelegate

/**
    Fucntions pertaining to the display and dismissal of the picker created by the mass unit button.
 */
extension ExerciseCounterViewController: MassUnitButtonDelegate {
    
    func massUnitButton(unitButton: MassUnitButton, shouldDismissPickerView pickerView: UIPickerView) {
        pickerView.removeFromSuperview()
        
        weightSetConstraint.active = true
    }
    
    func massUnitButton(unitButton: MassUnitButton, shouldDisplayPickerView pickerView: UIPickerView) {
        guard let addSetLabel = weightSetConstraint?.firstItem as? UILabel,
            weightTextField = weightSetConstraint?.secondItem as? UITextField else {
                return
        }
        
        dismissKeyboard()
        
        weightSetConstraint.active = false
        
        view.insertSubview(pickerView, belowSubview: unitButton)
        view.bringSubviewToFront(weightTextField)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
    
        let topConstraint = pickerView.topAnchor.constraintEqualToAnchor(weightTextField.bottomAnchor)
        topConstraint.constant = -40.0
        topConstraint.active = true
        pickerView.bottomAnchor.constraintEqualToAnchor(addSetLabel.topAnchor).active = true
        pickerView.centerXAnchor.constraintEqualToAnchor(weightTextField.centerXAnchor).active = true
    }
    
}
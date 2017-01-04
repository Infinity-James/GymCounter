//
//  MassUnitButton.swift
//  GymCounter
//
//  Created by James Valaitis on 07/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Mass Unit Button Class

/**
    `MassUnitButton`
 
    A button which allows the user to select between different units of measuring mass.
 */
class MassUnitButton: UIButton {
    
    //	MARK: Properties
    
    fileprivate var unitPickerView: UIPickerView?
    
    /// The measurement units available to the user.
    fileprivate let measurementUnits: [MeasurementUnit] = [.metric, .imperial]
    /// The selected measurement unit.
    var selectedMeasurementUnit = MeasurementUnit.metric {
        didSet {
            setTitle(selectedMeasurementUnit.massUnitString, for: UIControlState())
        }
    }
    /// An object which will respond to actions in this button.
    var unitButtonDelegate: MassUnitButtonDelegate?
    
    //	MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup() {
        addTarget(self, action: #selector(MassUnitButton.tapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { [weak self] notification in
            
            guard let strongSelf = self else { return }
            
            strongSelf.dismissPickerView()
        }
    }
    
    //	MARK: Actions
    
    @objc fileprivate func tapped() {
        if let unitPickerView = unitPickerView {
            unitButtonDelegate?.massUnitButton(self, shouldDismissPickerView: unitPickerView)
            self.unitPickerView = nil
            return
        }
        
        //  create a way for the user to select the measurement unit
        unitPickerView = UIPickerView()
        let selectedIndex = measurementUnits.index(of: selectedMeasurementUnit)!
        unitPickerView?.selectRow(selectedIndex, inComponent: 0, animated: false)
        unitPickerView!.dataSource = self
        unitPickerView!.delegate = self
        
        unitButtonDelegate?.massUnitButton(self, shouldDisplayPickerView: unitPickerView!)
    }
    
    //	MARK: Picker View Management
    
    /**
        If the picker view is shown, dismiss it.
     */
    func dismissPickerView() {
        guard let unitPickerView = unitPickerView else { return }
        
        unitButtonDelegate?.massUnitButton(self, shouldDismissPickerView: unitPickerView)
        self.unitPickerView = nil
    }
}

//	MARK: UIPickerViewDataSource

extension MassUnitButton: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return measurementUnits.count
    }
}

//	MARK: UIPickerViewDelegate

extension MassUnitButton: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let measurementUnit = measurementUnits[row]
        return measurementUnit.massUnitString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMeasurementUnit = measurementUnits[row]
    }
}

//	MARK: Mass Unit Button Delegate Protocol

protocol MassUnitButtonDelegate {
    /**
        This is called when the picker view should be displayed.
        
        - Parameter unitButton:     The unit button requesting that the picker view be displayed.
        - Parameter pickerView:     The `UIPickerView` to display.
     */
    func massUnitButton(_ unitButton: MassUnitButton, shouldDisplayPickerView pickerView: UIPickerView)
    /**
        This is called when the picker view should be dismissed.
     
        - Parameter unitButton:     The unit button requesting that the picker view be dismissed.
        - Parameter pickerView:     The `UIPickerView` to dismiss.
     */
    func massUnitButton(_ unitButton: MassUnitButton, shouldDismissPickerView pickerView: UIPickerView)
}

//
//  SetCollectionViewCell.swift
//  GymCounter
//
//  Created by James Valaitis on 24/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Set Collection View Cell Class

/**
    `SetCollectionViewCell`
 
    A cell which represents a set performed of an exercise.
 */
class SetCollectionViewCell: UICollectionViewCell {
    
    //	MARK: Properties
    
    //  The set to be displayed in this cell.
    var set: Set? {
        didSet {
            guard let set = set else { return }
            
            weightLabel.text = String(set.weight) + set.weightMeasurementUnit.massUnitString
            repsLabel.text = String(set.reps)
        }
    }
    //  The label that displays the weight performed in the set.
    @IBOutlet private var weightLabel: UILabel!
    //  The label that displays the reps performed in the set.
    @IBOutlet private var repsLabel: UILabel!
}

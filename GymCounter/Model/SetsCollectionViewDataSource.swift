//
//  SetsCollectionViewDataSource.swift
//  GymCounter
//
//  Created by James Valaitis on 24/04/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Sets Collection View Data Source

/**
    `SetsCollectionViewDataSource`
 
    A data source for the colleciton view which displays the sets performed in an exercise.
 */
class SetsCollectionViewDataSource: NSObject {
    
    //	MARK: Property
    
    /// The collection view that we provide the data for.
    weak var collectionView: UICollectionView?
    //  Reuse identifier for the cells.
    private let reuseIdentifier = String(SetCollectionViewCell)
    //  The exercise whose sets need to be displayed.
    var exercise: Exercise {
        didSet {
            collectionView?.reloadData()
            
            if exercise.sets.count > 0 {
                let lastIndexPath = NSIndexPath(forItem: exercise.sets.count - 1, inSection: 0)
                
                collectionView?.scrollToItemAtIndexPath(lastIndexPath, atScrollPosition: .Right, animated: true)
            }
        }
    }
    
    //	MARK: Initialization
    
    init(withExercise exercise: Exercise = Exercise(sets: [], name: "", repTarget: 8)) {
        self.exercise = exercise
        
        super.init()
    }
}

extension SetsCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? SetCollectionViewCell else {
            fatalError("Could not dequeue a cell with the reuse identifier \(reuseIdentifier).")
        }
        
        let set = exercise.sets[indexPath.item]
        cell.set = set
        cell.setNumber = indexPath.item + 1
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercise.sets.count
    }
}
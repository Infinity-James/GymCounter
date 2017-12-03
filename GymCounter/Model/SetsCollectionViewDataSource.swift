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
    fileprivate let reuseIdentifier = String(describing: SetCollectionViewCell.self)
    //  The exercise whose sets need to be displayed.
    var exercise: Exercise {
        didSet {
            collectionView?.reloadData()
            
            if exercise.sets.count > 0 {
                let lastIndexPath = IndexPath(item: exercise.sets.count - 1, section: 0)
                
                collectionView?.scrollToItem(at: lastIndexPath, at: .right, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SetCollectionViewCell else {
            fatalError("Could not dequeue a cell with the reuse identifier \(reuseIdentifier).")
        }
        
        let set = exercise.sets[indexPath.item]
        cell.set = set
        cell.setNumber = indexPath.item + 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercise.sets.count
    }
}

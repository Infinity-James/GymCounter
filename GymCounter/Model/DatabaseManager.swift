//
//  DatabaseManager.swift
//  GymCounter
//
//  Created by James Valaitis on 24/08/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import Foundation
import RealmSwift

//  MARK: Database Manager

public struct DatabaseManager {
	
	//  MARK: Properties
	
	fileprivate static let operationQueue: OperationQueue = {
		let queue = OperationQueue()
		queue.name = "Database Queue"
		return queue
	}()
	
	//  MARK: Saving
	
	public static func save(exercise: Exercise) {
		let entity = exercise.exerciseEntity
		do {
			let realm = try Realm()
			realm.add(entity)
		} catch {
			print("Error occurred whilst saving exercise into Realm database: \(error)")
		}
	}
	
	//  MARK: Loading
	
	public static func loadAllExercises(_ completion: @escaping (_ exercises: [Exercise]?, _ error: Error?) -> ()) {
		operationQueue.addOperation {
			do {
				let realm = try Realm()
				let entities = realm.objects(ExerciseEntity.self)
				let exercises = entities.map { $0.exercise }
				completion(Array(exercises), nil)
			} catch {
				completion(nil, error)
			}
		}
	}
}

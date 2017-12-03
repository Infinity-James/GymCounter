//
//  ExerciseMapping.swift
//  GymCounter
//
//  Created by James Valaitis on 24/08/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import Foundation

//  MARK: Exercise -> ExerciseEntity Mapping

extension Exercise {
	var exerciseEntity: ExerciseEntity {
		let exerciseEntity = ExerciseEntity()
		
		exerciseEntity.exerciseName = name
		exerciseEntity.repTarget = repTarget
		let setsJSON = sets.map { $0.json }
		do {
			let data = try JSONSerialization.data(withJSONObject: setsJSON, options: [])
			exerciseEntity.setsData = data
		} catch {
			print("Error occurred whilst serializing sets: \(error)")
		}
		
		return exerciseEntity
	}
}

//  MARK: ExerciseEntity -> Exercise

extension ExerciseEntity {
	var exercise: Exercise {
		do {
			guard let setsJSON = try JSONSerialization.jsonObject(with: setsData as Data, options: []) as? [JSONValue] else {
				fatalError("Could not serialize data into JSON: \(setsData)")
			}
			let sets = setsJSON.flatMap { Set(json: $0) }
			let exercise = Exercise(sets: sets, name: exerciseName, repTarget: repTarget)
			return exercise
		} catch {
			fatalError("Error occurred whilst serializing data into sets JSON: \(error)")
		}
	}
}

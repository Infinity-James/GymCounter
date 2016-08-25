//
//  ExerciseEntity.swift
//  GymCounter
//
//  Created by James Valaitis on 23/08/2016.
//  Copyright © 2016 &Beyond. All rights reserved.
//

import Foundation
import RealmSwift

//  MARK: Exercise Entity

final class ExerciseEntity: Object {
	var setsData = NSData()
	var exerciseName = ""
	var repTarget: Int?
}

//  MARK: Set Persistence

let setRepsKey = "reps"
let setWeightKey = "weight"
let setWeightMeasurementUnitKey = "weightMeasurementUnit"

extension Set {
	var json: JSONValue {
		var json: JSONValue = [setRepsKey: reps]
		json[setWeightKey] = weight
		json[setWeightMeasurementUnitKey] = weightMeasurementUnit.string
		return json
	}
	
	init?(json: JSONValue) {
		guard let reps = json[setRepsKey] as? Int,
			weight = json[setWeightKey] as? Double,
			measurementUnitString = json[setWeightMeasurementUnitKey] as? String,
			measurementUnit = MeasurementUnit(string: measurementUnitString) else {
			return nil
		}
		
		self.reps = reps
		self.weight = weight
		self.weightMeasurementUnit = measurementUnit
	}
}

//  MARK: Measurement Unit Persistence

private let imperialString = "imperial"
private let metricString = "metric"

extension MeasurementUnit {
	var string: String {
		switch self {
		case .Imperial:
			return imperialString
		case .Metric:
			return metricString
		}
	}
	
	init?(string: String) {
		switch string {
		case imperialString:
			self = .Imperial
		case metricString:
			self = .Metric
		default:
			return nil
		}
	}
}
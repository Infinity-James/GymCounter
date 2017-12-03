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
	var setsData = Data()
	var exerciseName = ""
	var repTarget: Int?
}

//  MARK: Set Persistence

let setRepsKey = "reps"
let setWeightKey = "weight"
let setWeightMeasurementUnitKey = "weightMeasurementUnit"

extension Set {
	var json: JSONValue {
		var json: JSONValue = [setRepsKey: reps as AnyObject]
		json[setWeightKey] = weight as AnyObject?
		json[setWeightMeasurementUnitKey] = weightMeasurementUnit.string as AnyObject?
		return json
	}
	
	init?(json: JSONValue) {
		guard let reps = json[setRepsKey] as? Int,
			let weight = json[setWeightKey] as? Double,
			let measurementUnitString = json[setWeightMeasurementUnitKey] as? String,
			let measurementUnit = MeasurementUnit(string: measurementUnitString) else {
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
		case .imperial:
			return imperialString
		case .metric:
			return metricString
		}
	}
	
	init?(string: String) {
		switch string {
		case imperialString:
			self = .imperial
		case metricString:
			self = .metric
		default:
			return nil
		}
	}
}

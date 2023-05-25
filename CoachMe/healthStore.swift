//
//  healthStore.swift
//  CoachMe
//
//  Created by duaa mohammed on 18/05/2023.
//

import Foundation
import HealthKit
import SwiftUI
// anchore date
extension Date {
    static func mondayAt12AM () -> Date {
        return  Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear , .weekOfYear],from: Date()))!
    }
}
class HealthStore {
    var healthStore:HKHealthStore?
//    let healthStore = HKHealthStore()
   // var builder: HKLiveWorkoutBuilder?
    var hearrateResult : Double?
    
    init() {
        //builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        if HKHealthStore.isHealthDataAvailable() {
            
            healthStore = HKHealthStore()
        }
    }
    // autherization function allow permssion
    func requestAuteraziation(compliation:@escaping (Bool) -> (Void)) async{
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let heartRate = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let caloriesBurned = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let activitey = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        guard let healthStore = self.healthStore else {return  compliation(false)}
        
        
        
        healthStore.requestAuthorization(toShare: [], read: [stepType,heartRate,caloriesBurned,activitey]){
            (sucess, error) in
            compliation(sucess)
        }
        //(toShare: write, read: read)
//        guard res != nil else {
//            return false
//        }
//
//        healthStore.requestAuthorization(toShare: , read: ){
//            (success , error) in compliation(success)
//        }
    }
    
// steps calculation  function
    func calcualteSteps(complation :@escaping (HKStatisticsCollection?) ->(Void)){
        var query :HKStatisticsCollectionQuery
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let now = Date()
           let startOfDay = Calendar.current.startOfDay(for: now)
        let daily = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(
                withStart: startOfDay,
                end: now,
                options: .strictStartDate
            )
       query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options:.cumulativeSum, anchorDate: startOfDay, intervalComponents: daily)
        query.initialResultsHandler = { query , statisticCollection , error in
            complation(statisticCollection)
        }
        if let healthStore = healthStore {
            healthStore.execute(query)
        }
    }
    
    // calories
    func calcualteCalories(complation :@escaping (HKStatisticsCollection?) ->(Void)){
        var query :HKStatisticsCollectionQuery
        let calorieType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let now = Date()
           let startOfDay = Calendar.current.startOfDay(for: now)
        let daily = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(
                withStart: startOfDay,
                end: now,
                options: .strictStartDate
            )
       query = HKStatisticsCollectionQuery(quantityType: calorieType, quantitySamplePredicate: predicate,options:.cumulativeSum, anchorDate: startOfDay, intervalComponents: daily)
        query.initialResultsHandler = { query , statisticCollection , error in
            complation(statisticCollection)
        }
        if let healthStore = healthStore {
            healthStore.execute(query)
        }
    }
    // heartrate
    func calcualteHeartRate(complation :@escaping (HKStatisticsCollection?) ->(Void)){
        var query :HKStatisticsCollectionQuery
        let rateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let now = Date()
           let startOfDay = Calendar.current.startOfDay(for: now)
        let daily = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(
                withStart: startOfDay,
                end: now,
                options: .strictStartDate
            )
        query = HKStatisticsCollectionQuery(quantityType: rateType, quantitySamplePredicate: predicate,anchorDate: startOfDay, intervalComponents: daily)
        query.initialResultsHandler = { query , statisticCollection , error in
            complation(statisticCollection)
        }
        if let healthStore = healthStore {
            healthStore.execute(query)
        }
        
        //reading acyivites from health app
    }
    
//    func getWorkoutRoute(workout: HKWorkout) async -> [HKWorkoutRoute]? {
//        let byWorkout = HKQuery.predicateForObjects(from: workout)
//
//        let samples = try! await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKSample], Error>) in
//            healthStore?.execute(HKAnchoredObjectQuery(type: HKSeriesType.workoutRoute(), predicate: byWorkout, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: { (query, samples, deletedObjects, anchor, error) in
//                if let hasError = error {
//                    continuation.resume(throwing: hasError)
//                    return
//                }
//
//                guard let samples = samples else {
//                    return
//                }
//
//                continuation.resume(returning: samples)
//            }))
//        }
//
//        guard let workouts = samples as? [HKWorkoutRoute] else {
//            return nil
//        }
//
//        return workouts
//    }
//    func readWorkouts() async -> [HKWorkout]? {
//        let cycling = HKQuery.predicateForWorkouts(with: .cycling)
//
//        let samples = try! await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKSample], Error>) in
//            healthStore?.execute(HKSampleQuery(sampleType: .workoutType(), predicate: cycling, limit: HKObjectQueryNoLimit,sortDescriptors: [.init(keyPath: \HKSample.startDate, ascending: false)], resultsHandler: { query, samples, error in
//                if let hasError = error {
//                    continuation.resume(throwing: hasError)
//                    return
//                }
//                guard let samples = samples else {
//                    fatalError("*** Invalid State: This can only fail if there was an error. ***")
//                }
//
//                continuation.resume(returning: samples)
//                print(samples.count)
//            }))
//        }
//
//        guard let workouts = samples as? [HKWorkout] else {
//            return nil
//        }
//
////        print(wo)
//        return workouts
//    }
    func calcualteActivitey(complation :@escaping (HKStatisticsCollection?) ->(Void)){
        
        var query :HKStatisticsCollectionQuery
        let ActivityType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
//        let runningObjectQuery = HKQuery.predicateForObjects(from: myWorkout)
        let startOfDay = Calendar.current.date(byAdding: .day, value: -7 , to: Date())
        let daily = DateComponents(day: 1)
        let anchore = Date.mondayAt12AM()
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay,end: Date(),options: .strictStartDate)
        
        print("XX:\(ActivityType.debugDescription)")
        query = HKStatisticsCollectionQuery(quantityType: ActivityType, quantitySamplePredicate: predicate,options:.cumulativeSum, anchorDate: anchore, intervalComponents: daily )
        
        
        query.initialResultsHandler = { query , statisticCollection , error in
            complation(statisticCollection)
        }
        if let healthStore = healthStore {
            healthStore.execute(query)
        }
        
    }
    
 






}




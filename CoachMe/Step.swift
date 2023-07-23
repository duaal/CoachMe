//
//  Step.swift
//  CoachMe
//
//  Created by duaa mohammed on 21/05/2023.
//
import HealthKit
import Foundation
import Foundation
struct Step:Identifiable,Hashable {
    let id = UUID()
    let count:Int
    let date:Date
}

struct Calorie: Identifiable,Hashable  {
    let id = UUID()
    let calories :Int
    let date:Date
}

struct HeartRate : Identifiable , Hashable {
    let id = UUID()
    let heartRate :Int
    let date:Date
}
struct Activity : Identifiable , Hashable {
    let id = UUID()
    let min :Int
    let date:Date
}

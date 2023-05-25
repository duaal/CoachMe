//
//  chartData.swift
//  CoachMe
//
//  Created by duaa mohammed on 10/05/2023.
//

import Foundation
struct chartData :Identifiable{
    let id = UUID()
    let day : String
    let min : Int

//    init (day:String ,min :Int){
//        let format = DateFormatter()
//        format.dateFormat = "dd"
//        self.weekdays = format.date(from: day) ?? Date.distantPast
//        self.min = min
//    }
//
//    var weekday: String {
//        let dateFormatter = DateFormatter()
//        return String(dateFormatter)
//    }
}


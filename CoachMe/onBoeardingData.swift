//
//  onBoeardingData.swift
//  CoachMe
//
//  Created by duaa mohammed on 07/05/2023.
//

import Foundation


struct pageInfo {
    let title:String
    let paragraph :String
    let image :String
}
extension pageInfo{
    static func all() -> [pageInfo]{
       return[pageInfo(title: "Your Personal Coach", paragraph: "CoachMe is an app designed to help you achieve optimal posture and enhance your physical fitness.", image: "weight"),
       pageInfo(title: "Artificial Intelligence", paragraph: "we offer a personalized approach to fitness that can help you reach your goals more efficiently.", image: "jumpingRope"),
              pageInfo(title: "Track  Achievement", paragraph: "By participating in our challenges, you not only get to enjoy a fun workout, but also earn awards.", image: "sumo")
       ]
    }
}

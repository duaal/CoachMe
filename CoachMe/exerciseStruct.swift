//
//  exerciseStruct.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import Foundation
struct exercise {
   
    
    let name : String
    let image :String
    let description :String
    let eqipment : [String]
    let level : String
    let type :String
    let typeimage : String
    let levelImage :String
 
}

extension exercise {
    static func all() -> [exercise]{
        return [
        exercise(name: "Squat", image: "Squat", description: "King Pigeon Pose is a seated back-bending asana in modern yoga as exercise. The Yin Yoga form of the asana is named Swan Pose, while the Aerial yoga variant, supported in a hammock, is called Flying Pigeon Pose", eqipment: ["Yoga Matt"], level: "Beginner", type: "Strength" ,typeimage: "figure.strengthtraining.traditional" , levelImage: "cellularbars"),
        exercise(name: "Plank", image: "Plank", description: "here will be some discription about the squate", eqipment: ["Yoga Matt"], level: "Beginner", type: "Core",typeimage: "figure.core.training" , levelImage: "cellularbars")
        
        
        
        ]
    }
}


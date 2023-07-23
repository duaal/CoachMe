//
//  exerciseStruct.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import Foundation
import SwiftUI
struct exercise {
   
    
    let name : String
    let image :String
    let description :String
    let eqipment : [String]
    let level : String
    let type :String
    let typeimage : String
    let levelImage :String
    let gif :String
    var eview :any View
    var index : Int
    
 
}

extension exercise {
    static func all() -> [exercise]{
        return [
        exercise(name: "Squat", image: "Squat", description: "With over 256 muscles activated in one movement, the squat is the most effective exercise.Compound exercises like the squat are popular among bodybuilders, powerlifters, and competitive athletes.", eqipment: ["Yoga Matt"], level: "Beginner", type: "Strength" ,typeimage: "figure.strengthtraining.traditional" , levelImage: "cellularbars",gif: "mini-squat-gif",eview: squat(),index: 0),    exercise(name: "Jumping Jack", image: "jumpingjack", description: "Jumping jacks are a great full body exercise that enhances aerobic fitness, strengthens the body, and promotes relaxation. This exercise also improves muscle endurance, increases the body’s metabolic rate, and helps with weight loss.", eqipment: ["Yoga Matt"], level: "Beginner", type: "cardio" ,typeimage: "figure.mixed.cardio" , levelImage: "cellularbars",gif: "jump",eview: comingSoon(),index: 0),    exercise(name: "Pushup", image: "pushup", description: "push-up largely targets the muscles of the chest, the pectoralis major and minor, several other muscle groups contribute. Namely, these include the triceps, anterior deltoids, and the core muscles.", eqipment: ["Yoga Matt"], level: "Intermediate", type: "Strength" ,typeimage: "figure.strengthtraining.traditional" , levelImage: "cellularbars",gif: "pushups",eview: comingSoon(),index: 0)
        
        
        
        ]
    }
}


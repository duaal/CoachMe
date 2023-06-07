//
//  Predicate.swift
//  CoachMe
//
//  Created by duaa mohammed on 01/06/2023.
//

import Foundation
import Vision
protocol PredicatorDelegate: AnyObject {
    func predictor (_ predictor:Predicate , didFindNewRecognizedPoints poits:[CGPoint])
}
class Predicate {
    weak var delegate: PredicatorDelegate?
    func estimation (sampleBuffer : CMSampleBuffer ){
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer , orientation: .up)
        let request = VNDetectHumanBodyPoseRequest(completionHandler:  bodyPoseHandler)
        do {
            try requestHandler.perform([request])
        }catch{
            print("unable to perform rrques \(error)" )
        }
    }
    func bodyPoseHandler (request : VNRequest , error:Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else {return}
        observations.forEach{
            processObservation($0)
        }
    }
    func processObservation (_ observation : VNHumanBodyPoseObservation){
        do{
            let recognizPoints = try observation.recognizedPoints(forGroupKey: .all)
            let displayedPoints = recognizPoints.map{
                CGPoint(x:$0.value.x , y: 1 - $0.value.y)
            }
            delegate?.predictor(self , didFindNewRecognizedPoints: displayedPoints)
        }catch{
            print ("error finding recognized points")
        }
    }
}

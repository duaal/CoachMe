//
//  predictor.swift
//  CoachMe
//
//  Created by duaa mohammed on 09/06/2023.
//

import Foundation
import Vision
protocol PredicatorDelegate: AnyObject {
    func predictor (_ predictor:Predicate , didFindNewRecognizedPoints points:[CGPoint])
    func predictor(_ predictor:Predicate, didLabelAction action:String, with confidence: Double)
}
class Predicate {
    weak var delegate: PredicatorDelegate?
    let prdictioWindowSize = 150
    var poseWindow:[VNHumanBodyPoseObservation] = []
    init(){
        poseWindow.reserveCapacity(prdictioWindowSize)
    }
    func estimation (sampleBuffer : CMSampleBuffer ){
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer , orientation: .up)
        let request = VNDetectHumanBodyPoseRequest(completionHandler:  bodyPoseHandler)
        do {
            try requestHandler.perform([request])
        }catch{
            print("unable to perform rquest \(error)" )
        }
    }
    func bodyPoseHandler (request : VNRequest , error:Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else {return}
        observations.forEach{
            processObservation($0)
        }
        if let result = observations.first{
            storeObservation(result)
        }
    }
    func storeObservation (_ observation :VNHumanBodyPoseObservation){
        if poseWindow.count >= prdictioWindowSize {
            poseWindow.removeFirst()
        }
        poseWindow.append(observation)
        lableActionType()
    }
    func lableActionType(){
        guard let throwingCassifier = try? Squat_5(configuration:MLModelConfiguration()),
                let poseMultiArray = prepareInputWithObservations(poseWindow),
              let predictions = try? throwingCassifier.prediction(poses: poseMultiArray) else{
            return
        }
        let lable = predictions.label
        let confidence = predictions.labelProbabilities[lable] ?? 0
        delegate?.predictor(self, didLabelAction: lable, with: confidence)
    }
    func prepareInputWithObservations (_ observations: [VNHumanBodyPoseObservation])-> MLMultiArray? {
        let numAvailableFrams = observations.count
        let observationNeeded = 60
        var multiArrayBuffer = [MLMultiArray]()
        for frameIndex in 0 ..< min(numAvailableFrams,observationNeeded){
            let pose = observations[frameIndex]
            do{
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            }catch{
                continue
            }
        }
        if numAvailableFrams < observationNeeded {
            for _ in 0 ..< (observationNeeded - numAvailableFrams) {
                do{
                    let oneFrameMultiArray = try MLMultiArray(shape: [1,3,18], dataType: .double)
                    try resetMultiArray(oneFrameMultiArray)
                    multiArrayBuffer.append(oneFrameMultiArray)
                    
                }catch {
                    continue
                }
            }
        }
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float)
    }
    func resetMultiArray(_ predictionWindow: MLMultiArray , with value:Double = 0.0) throws{
        let pointer = try UnsafeMutableBufferPointer <Double>(predictionWindow)
        pointer.initialize(repeating: value)
        
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


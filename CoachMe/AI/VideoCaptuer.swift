//
//  VideoCaptuer.swift
//  CoachMe
//
//  Created by duaa mohammed on 09/06/2023.
//


import Foundation
import AVFoundation
class VideoCapture:NSObject {
    let predictor = Predicate()
    let captuerSession = AVCaptureSession()
    let videOutput = AVCaptureVideoDataOutput()
    
    override init() {
        guard let captuerDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: captuerDevice) else {
            return
        }
        captuerSession.sessionPreset = AVCaptureSession.Preset.high
        captuerSession.addInput(input)
        captuerSession.addOutput(videOutput)
        videOutput.alwaysDiscardsLateVideoFrames = true
    }
    func startCaptureSession(){
        
            captuerSession.startRunning()
       
        videOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatcher"))
    }
}
extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
       
        
    }
}

//
//  VideoCaptuer.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import Foundation
import AVFoundation
class VideoCaptuer:NSObject {
    let captuerSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    let predictor = Predicate()
    override init() {
        super.init()
        guard let captuerDevice = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: captuerDevice) else {
            return
        }
        captuerSession.sessionPreset = AVCaptureSession.Preset.high
        captuerSession.addInput(input)
        captuerSession.addOutput(videoOutput)
        videoOutput.alwaysDiscardsLateVideoFrames = true
    }
    func startCaptureSession(){
        captuerSession.stopRunning()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
}
extension VideoCaptuer: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer:CMSampleBuffer,from connection:AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}

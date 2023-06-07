//
//  viewController.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation
import Vision


class ViewController: UIViewController {
    let videoCapture = VideoCaptuer()
    private var permissionGranted = false // Flag for permission
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private var previewLayer :AVCaptureVideoPreviewLayer?
    var pointLayer = CAShapeLayer()
    var screenRect: CGRect! = nil // For view dimensions
    
    override func viewDidLoad() {
        checkPermission()
        
        sessionQueue.async { [unowned self] in
            guard permissionGranted else { return }
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
//        videoCapture.predicate.delegate = self
        videoCapture.predictor.delegate = self
    }
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            // Permission has been granted before
        case .authorized:
            permissionGranted = true
            
            // Permission has not been requested yet
        case .notDetermined:
            requestPermission()
            
        default:
            permissionGranted = false
        }
    }
    func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }
    func setupCaptureSession() {
        // Access camera
        videoCapture.startCaptureSession()
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .front) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        let videoOut = AVCaptureVideoDataOutput()
        let predictor = Predicate()
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        // TODO: Add preview layer
        screenRect = UIScreen.main.bounds
        
//        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captuerSession)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//               previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
//               previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
//               previewLayer.connection?.videoOrientation = .portrait
        
        guard let previewLayer = previewLayer else {return}
      
//        previewLayer.frame = view.frame
        pointLayer.frame = view.frame
        pointLayer.strokeColor = UIColor.black.cgColor
//        view.layer.addSublayer(pointLayer)
        pointLayer.frame = view.frame
        pointLayer.strokeColor = UIColor.black.cgColor

//        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
//
        
        previewLayer.connection?.videoOrientation = .portrait
        DispatchQueue.main.async { [weak self] in
            previewLayer.frame = self!.view.frame
            self!.pointLayer.frame =  self!.view.frame
            self!.view.layer.addSublayer(self!.pointLayer)
            self!.view.layer.addSublayer(self!.previewLayer!)
          
            print( "here some data",self!.pointLayer)
        }
      }
    
    
    
}
struct HostedViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

extension ViewController:PredicatorDelegate {
    func predictor(_ predictor: Predicate, didFindNewRecognizedPoints poits: [CGPoint]) {
        guard let previewLayer = previewLayer else { return }
        let convertPoint = poits.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        let combinePAth =  CGMutablePath()
        for poit in convertPoint {
            _ = UIBezierPath(ovalIn: CGRect(x:poit.x , y: poit.y , width:  10 , height: 10))
        }
        pointLayer.path = combinePAth
                DispatchQueue.main.async {
                
                    self.pointLayer.didChangeValue(for: \.path)
                }
    }
    
    
}

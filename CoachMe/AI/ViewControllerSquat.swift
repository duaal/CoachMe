//
//  ViewControllerSquat.swift
//  CoachMe
//
//  Created by duaa mohammed on 09/06/2023.
//


import UIKit
import Foundation
import AVFoundation
import SwiftUI
import AudioToolbox
var modelname = ""
var modelvalue = ""
var countermain = -1
var acuressy = 0.0
var acuressy2 = 0
let defaults = UserDefaults.standard
class Indxes: ObservableObject {
    @Published var Indxes: [Int] {
        didSet {
            UserDefaults.standard.set(Indxes, forKey: "Indxes")
        }
      
    }
    init(){
        self.Indxes = UserDefaults.standard.object(forKey: "Indxes") as? [Int] ?? []
    }
}
class Counter: ObservableObject {
    @Published var Counter: Int {
        didSet {
            UserDefaults.standard.set(Counter, forKey: "counter2")
        }
      
    }
    init(){
        self.Counter = UserDefaults.standard.object(forKey: "counter2") as? Int ?? 0
    }
}

class Acursey: ObservableObject {
    @Published var Acursey: Double {
        didSet {
            UserDefaults.standard.set(Acursey, forKey: "acursey")
        }
      
    }
    init(){
        self.Acursey = UserDefaults.standard.object(forKey: "acursey") as? Double ?? 0.0
    }
}


//@MainActor class CounterO: ObservableObject {
//    @Published var counter = defaults.integer(forKey: "Acursey")
//
//}

class ViewController: UIViewController {
//    @StateObject var data = CounterO()
    var lable:UILabel!
//    var model = CounterO()
//  var test = CounterO().counter
    let videoCapture = VideoCapture()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var pointsLayer = CAShapeLayer()
    var isPlankDetected = false
    @State var result :Int = 0
    override func viewDidLoad() {
        UserDefaults.standard.set(0, forKey: "counter2")
        UserDefaults.standard.set(0.0, forKey: "acursey")
        super.viewDidLoad()
        setupVideoPeview()
        videoCapture.predictor.delegate = self
         
              
//        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    }
    private func setupVideoPeview(){
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captuerSession)
        
        guard let previewLayer = previewLayer else {return}
   
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
      
       
       


  
        view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.white.cgColor
        pointsLayer.fillColor = UIColor.white.cgColor
    }
    
}


extension ViewController: PredicatorDelegate{

    func predictor(_ predictor: Predicate, didLabelAction action: String, with confidence: Double) {
        if defaults.double(forKey: "acursey") != 0 {
            print(action)}
        if action == "good"{
            if defaults.double(forKey: "acursey") >= 0.80 && confidence >= 0.80{
                DispatchQueue.main.asyncAfter(deadline: .now()+2 ){
                    defaults.setValue(confidence, forKey: "acursey")            }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1 ){
                    defaults.setValue(confidence, forKey: "acursey")            }
            }
            acuressy = defaults.double(forKey: "acursey")
            print("this is the acuressy\(acuressy)")
        }
        if action == "good" && confidence >= 0.85 && isPlankDetected == false {
            print ("plank Detected")
            countermain = countermain + 1
           
            defaults.setValue(countermain, forKey: "counter2")
           
            isPlankDetected = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                           defaults.setValue(confidence, forKey: "acursey")
                           self.isPlankDetected = false
                       }
  
       
        }
//        if action == "none"{
//            if defaults.double(forKey: "acursey") != 0 {
//                DispatchQueue.main.asyncAfter(deadline: .now()+1){
//                    defaults.setValue(0.0, forKey: "acursey")            }
//            }
//
//        }
//
//        if action == "good" && confidence >= 0.80 && isPlankDetected == false {
//            print ("plank Detected")
//            isPlankDetected = true
//            DispatchQueue.main.asyncAfter(deadline: .now()+3){
//                self.isPlankDetected = false
//            }
//            DispatchQueue.main.sync {
//                AudioServicesPlayAlertSound(SystemSoundID(13229))
//            }
//            }
     
    }
    
    func predictor(_ predictor: Predicate, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else {return}
        let convertedPoints = points.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        let combinPath = CGMutablePath()
        for point in convertedPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinPath.addPath(dotPath.cgPath)
        }
        pointsLayer.path = combinPath
        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
}


struct HostedViewController: UIViewControllerRepresentable {
//    = defaults.integer(forKey: "counter2")
//    @Binding var Testcounter : Int
//    init(Testcounter: Int) {
//        self.Testcounter = countertester2
//    }
//    viewController._disableSafeArea = true

    func makeUIViewController(context: Context) -> UIViewController {
 
        return ViewController()
        
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}



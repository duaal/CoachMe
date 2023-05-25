//
//  parcahrt.swift
//  CoachMe
//
//  Created by duaa mohammed on 23/05/2023.
//

import Foundation
import SwiftUI

struct RingBackgroundShape: Shape {
    
    var thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2 - thickness,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: false
        )
        return path
            .strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
    
}
struct RingShape: Shape {
    
    var currentPercentage: Double
    var thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2 - thickness,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360 * currentPercentage),
            clockwise: false
        )
        
        return path
            .strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
    
    var animatableData: Double {
        get { return currentPercentage }
        set { currentPercentage = newValue }
    }
    
}

struct RingTipShape: Shape {
    
    var currentPercentage: Double
    var thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let angle = CGFloat((360 * currentPercentage) * .pi / 180)
        let controlRadius: CGFloat = rect.width / 2 - thickness
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let x = center.x + controlRadius * cos(angle)
        let y = center.y + controlRadius * sin(angle)
        let pointCenter = CGPoint(x: x, y: y)
        
        path.addEllipse(in:
            CGRect(
                x: pointCenter.x - thickness / 2,
                y: pointCenter.y - thickness / 2,
                width: thickness,
                height: thickness
            )
        )
        
        return path
    }
    
    var animatableData: Double {
        get { return currentPercentage }
        set { currentPercentage = newValue }
    }
    
}

struct PieChartView : View {
    @State var currentPercentage: Double = 1.0
        
    @State var percentage: Double 
        var backgroundColor: AngularGradient = AngularGradient(gradient: Gradient(colors: [Color("pinkchart"), Color("pinkchart2")]), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360 ))
    var startColor: Color = Color ("graidaneOne")
        var endColor: Color = Color ("graidaneTwo")
        var thickness: CGFloat = 33
    var stepCount : Int

        var animation: Animation {
            Animation.easeInOut(duration: 1)
        }
    var body: some View {
        let gradient = AngularGradient(gradient: Gradient(colors: [startColor, endColor]), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360 * currentPercentage))
        VStack{
            ZStack {
                VStack{
                    Text ("Steps").modifier(Title2()).foregroundColor(Color("grayText"))
                    Text ("\(stepCount)").modifier(Bodyfont()).foregroundColor(Color("grayText"))
                    
                }
                RingBackgroundShape(thickness: thickness)
                    .fill(backgroundColor)
                RingShape(currentPercentage: currentPercentage, thickness: thickness)
                    .fill(gradient)
                    .rotationEffect(.init(degrees: -90))
                    .shadow(radius: 2)
                    .drawingGroup()
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(self.animation) {
                                self.currentPercentage = self.percentage
                            }
                        }
                    }
                RingTipShape(currentPercentage: currentPercentage, thickness: thickness)
                    .fill(currentPercentage > 1 ? endColor : .clear)
                    .rotationEffect(.init(degrees: -90))
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(self.animation) {
                                self.currentPercentage = self.percentage
                            }
                        }
                    }
                
                
            }.frame(width: 238 , height: 238)
        }
    }
}
struct CalorieView : View {
    var calories : Int
    var body: some View{
        HStack (alignment: .lastTextBaseline){
       
            Spacer()
            Text("\(calories)").font(.system(size: 45 , weight: .bold)).foregroundColor(.white)
            Text("cal").modifier(Tag())
            Spacer()
        
        }.frame(width: 172 , height: 134 ).background(Color("primary")).cornerRadius(14)

    }
    
    
}
struct RateView : View {
    var heartRate : Double
    var body: some View{
        VStack {
          
            HStack (alignment: .lastTextBaseline ){
                
                Spacer()
                Image(systemName: "heart.fill")
                    .font(.system(size: 36)).foregroundColor(Color("red"))
                Text("\(Int (heartRate))").font(.system(size: 39 , weight: .bold)).foregroundColor(.white).minimumScaleFactor(0.9)
                Text("bpm").modifier(Tag())
                Spacer()
                
            }.padding(.top , 20)
            Image("heartRateline")
  
        }.frame(width: 172 , height: 134 ).background(Color("primary")).cornerRadius(14)
        
    }
    
    
}


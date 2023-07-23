//
//  beforeCounter.swift
//  CoachMe
//
//  Created by duaa mohammed on 07/06/2023.
//

import SwiftUI
import AVFoundation

struct beforeCounter: View {
    @State var countdown: CGFloat = 3
    let systemSoundID: SystemSoundID = 1000

    let timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common)
      .autoconnect()
      .prefix(3)
    var body: some View {
        
        VStack{
            CountdownView(countdown: $countdown)
                .onReceive(timer) { _ in
                    withAnimation(.timingCurve(0.23, 0.97, 0.08, 0.97, duration: 1.0)){
                        if (countdown != 0){
                            countdown -= 1.0
                            AudioServicesPlaySystemSound(systemSoundID)

                        }
                    }
                }.padding(80)
            
            
        }.onAppear{
            countdown = 3
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("graidaneOne")).foregroundColor(.white)
    }
}

struct beforeCounter_Previews: PreviewProvider {
    static var previews: some View {
        beforeCounter()
    }
}

struct CountdownView: View {
  @Binding var countdown: CGFloat

  var body: some View {
    ZStack {
      Text("\(String(format: "%.0f", min(3, ceil(countdown + 0.01))))")
        .font(Font.system(.largeTitle).monospacedDigit())
        .foregroundColor(Color(.white))
      Circle()
        .stroke(lineWidth: 15)
        .foregroundColor(Color(.darkGray)).opacity(0.4)
        .padding(10)
      Circle()
        .trim(from: 0, to: countdown / 3.0)
        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
        .rotation(Angle(degrees: 90))
        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
        .foregroundColor(Color(.white))
        .padding(10)
    }
 
  
  }
}

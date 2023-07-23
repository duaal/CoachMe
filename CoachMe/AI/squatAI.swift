//
//  squatAI.swift
//  CoachMe
//
//  Created by duaa mohammed on 09/06/2023.
//

import SwiftUI

struct squatAI: View {
    @State var test:Int = 0
    @AppStorage("counter2") var status:Int = 0
    @AppStorage("acursey") var acursey:Double = 0.0
    
    var body: some View {
//
        
        VStack{
           
            ZStack(alignment: .topTrailing){
                HostedViewController().frame(maxHeight: .infinity).ignoresSafeArea()
                VStack{
                    Text("counter \(status)").font(.system(size: 20 ,weight: .bold)).foregroundColor(.white).padding()}.background(Color("primary")).padding(2)
                    
             
                
                
            }
            
            HStack{
                VStack(alignment: .leading){
                    Text("% \(Int(acursey * 100) )").multilineTextAlignment(.leading).font(.system(size: 64 , weight: .bold)).foregroundColor(Int(acursey * 100) < 50 ? .red : .green)
                    Text("Need Help ? Watch This Video ").font(.system(size: 11 , weight: .semibold)).foregroundColor(.white)
                    Link(destination: URL(string: "https://www.youtube.com/watch?v=ubdIGnX2Hfs")!) {
                        HStack{
                            
                            Image(systemName: "play.circle.fill").foregroundColor(Color("primary"))
                            Text("Watch Squat Video").font(.system(size: 11 , weight: .semibold)).foregroundColor(.black)
                        }.padding(10).padding(.horizontal,10).background(.white).cornerRadius(16)
                    }}.padding(.horizontal, 20).padding(.bottom,10)
                Spacer()
            }.frame(maxWidth: .infinity , maxHeight: 180 ).background(Color("primary"))
        }
        }
        }
    



struct squatAI_Previews: PreviewProvider {
    static var previews: some View {
        squatAI()
    }
}

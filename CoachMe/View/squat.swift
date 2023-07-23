//
//  squat.swift
//  CoachMe
//
//  Created by duaa mohammed on 09/06/2023.
//

import SwiftUI

struct squat: View {
    @State var showCounter = 0
   
    var body: some View {
        var bullet  = Text ("\(Image(systemName: "circle.fill"))").font(.system(size: 7))
        VStack{
            if showCounter == 0 {
                VStack(alignment: .leading){
                
                     Spacer()
                    Text("Exercise Instructions").font(.system(size: 20 , weight: .black)).padding(25)
                        VStack(alignment: .leading){
                            Text("\(bullet) Make sure you're not wearing flowy clothes").padding(.vertical,8)
                            Text("\(bullet) Make sure you have good enough lighting ").padding(.vertical,8)
                            Text("\(bullet) Wait for the app to detect all your body joint ").padding(.vertical,8)
                            Text("\(bullet) Start exercising").fixedSize(horizontal: false, vertical: true).padding(.vertical,8)
                        }.font(.system(size: 14 , weight: .bold)).padding(25)
                 
                    
                Spacer()
                    VStack{
                        Text("START EXERCISE").font(.system(size: 15 , weight: .regular))
                        
                    }.frame(maxWidth: .infinity).padding().background(.black).cornerRadius(10).padding(50).onTapGesture {
                        showCounter = 1
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("graidaneOne")).foregroundColor(.white)
            }
            else if showCounter == 1 {
                beforeCounter().onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+3){
                     showCounter = 2
                    }
                }
            }
            else
            {squatAI()}
        }.accentColor(.white)
    }
    }


struct squat_Previews: PreviewProvider {
    static var previews: some View {
        squat()
    }
}

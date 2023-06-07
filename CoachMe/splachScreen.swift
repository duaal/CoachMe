//
//  splachScreen.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import SwiftUI

struct splachScreen: View {
    @State var isActive = true
    @State var scale = 0.0
    @State var opacity = 0.1
    var body: some View {
        if isActive{
            ZStack{
                Image("bg").resizable()
                VStack{
                    Image("logo")
                }.scaleEffect(scale).opacity(opacity).onAppear(){
                    withAnimation(.easeIn(duration: 0.7)){
                        self.scale = 0.8
                        self.opacity = 1.0
                    }
                }
            }.ignoresSafeArea().frame(maxWidth: .infinity , maxHeight:  .infinity).onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = false
                }
            }}
        else {
//   Nav()
            captureVideo()
        }
    }
  
}

struct splachScreen_Previews: PreviewProvider {
    static var previews: some View {
        splachScreen()
    }
}

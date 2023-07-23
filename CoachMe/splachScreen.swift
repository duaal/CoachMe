//
//  splachScreen.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import SwiftUI

struct splachScreen: View {
    @State var isActive = true
    @State private var opacity = 0.5
    @State private  var scale = 0.3
    var body: some View {
      
            
            if isActive{
                ZStack{
                  
                    VStack{
                     
                        Image("logo2")
        
                        Text("Train Like a Pro").foregroundColor(Color("primary")).font(.system(size: 35,weight: .semibold))
               
                    }.opacity(opacity).scaleEffect(scale).onAppear(){
                        withAnimation(.easeIn(duration: 0.4)){
                            self.opacity=2.0
                            self.scale = 0.8
                        }
                    }
                }.ignoresSafeArea().frame(maxWidth: .infinity , maxHeight:  .infinity).onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isActive = false
                    }
                }}
            else {
                  onBoreading()
            }
        
    }
}

struct splachScreen_Previews: PreviewProvider {
    static var previews: some View {
        splachScreen()
    }
}

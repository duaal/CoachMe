//
//  Main.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import SwiftUI

struct Main: View {
    let Exercise = exercise.all()
    var body: some View {
        VStack (alignment: .leading){
            VStack(alignment: .leading){
                Text("Let's Exercise!")
                    .font(.title)
                    .foregroundColor(Color("fontblack"))
                    .fontWeight(.bold)
                
                
                
                Text("Simple Movements for Maximum Effect.")
                    .foregroundColor(Color("grayText"))
                    .font(.system(size: 12 , weight: .semibold))
                    .fontWeight(.semibold)
                
                
                
                
              
            }.padding()
            Text("Exercise Positions")
                .foregroundColor(Color("grayText"))
                .font(.system(size: 14, weight: .bold)).padding(.horizontal).padding(.bottom,5)
                ForEach(self.Exercise , id:\.name){
                    exercise in
                    exerciseCard(title: exercise.name, type: exercise.type, level: exercise.level, typeimage: exercise.typeimage, levelimage: exercise.levelImage, exerciseImage: exercise.image).padding(.bottom,10)
                }
                
      Spacer()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

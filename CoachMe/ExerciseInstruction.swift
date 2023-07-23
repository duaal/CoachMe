//
//  ExerciseInstruction.swift
//  CoachMe
//
//  Created by duaa mohammed on 07/06/2023.
//

import SwiftUI

struct ExerciseInstruction: View {
    var body: some View {
        
        VStack(alignment: .center){
            HStack{
                Image(systemName: "megaphone").foregroundColor(.white).font(.system(size: 50,weight: .bold))
                Text("Coming Soon ").foregroundColor(.white).font(.system(size: 30,weight: .bold)).padding(.bottom,2)
            }
            Text("Stay Tuned ").foregroundColor(.white).font(.system(size: 30,weight: .bold))
            
            
        }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color("primary"))
    }
}
struct ExerciseInstruction_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseInstruction()
    }
}

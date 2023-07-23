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
        NavigationView{
            VStack (alignment: .leading){
                
                
                
                VStack(alignment: .leading){
                    HStack{
                        Text("Let's Exercise!")
                            .font(.title)
                            .foregroundColor(Color("fontblack"))
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination: HealthLog(), label: {
                            Image(systemName: "bolt.circle").font(.system(size: 30)).foregroundColor(Color("primary")).padding(.trailing).padding(.top)
                        })
                        
                    }.padding(.leading,5)
                    
                    Text("Simple Movements for Maximum Effect.")
                        .foregroundColor(Color("grayText"))
                        .font(.system(size: 12 , weight: .semibold))
                        .fontWeight(.semibold).padding(.horizontal,5)
                    
                    
                    
                    
                    
                }.padding()
                Text("Exercise Positions")
                    .foregroundColor(Color("grayText"))
                    .font(.system(size: 14, weight: .bold)).padding(.horizontal,18).padding(.bottom,5)
                ScrollView{
                    ForEach(self.Exercise , id:\.name){
                        
                        exercise in
                        NavigationLink(destination: DetailsPage(title: exercise.name, description: exercise.description, level: exercise.level, levelimage: exercise.levelImage, equpment: exercise.eqipment, gif: exercise.gif, eview: exercise.eview), label: {
                            exerciseCard(title: exercise.name, type: exercise.type, level: exercise.level, typeimage: exercise.typeimage, levelimage: exercise.levelImage, exerciseImage: exercise.image).padding(.bottom,10)
                        })
                    }
                    
                    Spacer()
                    
                }}
        }
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

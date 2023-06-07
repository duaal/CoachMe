//
//  exerciseCard.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import SwiftUI

struct exerciseCard: View {
    let title :String
    let type :String
    let level :String
    let typeimage :String
    let levelimage :String
    let exerciseImage:String
    var body : some View {
        ZStack (alignment: .leading){
            Image("\(exerciseImage)")
                .resizable()
                
                .cornerRadius(10)
                .foregroundColor(Color("Gray"))
//                .onTapGesture {
//                    isclicked = true
//                }
            VStack (alignment: .leading){
                Text("\(title)")
                    .font(.system(size: 32 , weight: .bold))
                    .foregroundColor(Color.white)
                   .padding()
              
                   Spacer()
                HStack{
                       
                    HStack{
                        Image(systemName: ("\(levelimage)"))
                            .font(.system(size: 10 ,weight: .bold)).foregroundColor(Color("primary"))
                        
                        Text("\(level)")
                            .fontWeight(.medium)
                            .font(.system(size: 10 , weight:.bold))
                            .foregroundColor(Color("primary"))
                        
                    }.padding(.horizontal,7).padding(.vertical,4).background(.white.opacity(0.8)).cornerRadius(50)
                
                  
            
                    HStack{
                        Image(systemName: ("\(typeimage)"))
                            .font(.system(size: 10 ,weight: .bold)).foregroundColor(.white)
                        Text("\(type)")
                            .font(.system(size: 10 ,weight:.medium))
                            .foregroundColor(Color.white)
                          
                    }.padding(.horizontal,7).padding(.vertical,4).background(Color("primary")).cornerRadius(50)

                        
                }.padding()
              
                    
            }
                   
                
            
            
        }.frame(maxWidth: .infinity ,maxHeight: 190).padding(.horizontal,20)
    }
}

struct exerciseCard_Previews: PreviewProvider {
    static var previews: some View {
        exerciseCard(title: "Squat", type: "Strength", level: "Beginner",typeimage: "figure.strengthtraining.traditional" , levelimage: "cellularbars",exerciseImage: "Squat")
    }
}

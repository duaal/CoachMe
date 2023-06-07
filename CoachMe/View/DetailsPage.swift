//
//  DetailsPage.swift
//  CoachMe
//
//  Created by duaa mohammed on 31/05/2023.
//

import SwiftUI

struct DetailsPage: View {

     
    let title:String
    let description :String
    let level :String
    let levelimage :String
    let equpment : [String]
        var body: some View {
       
            
            VStack (alignment: .leading){
                    
                GifImage("mini-squat-gif")
            
                    .frame(height: 400)
                   
    
             
              
                VStack{
                    
                    
                    HStack{
                        Text("\(title)")
                            .font(.title)
                            .foregroundColor(Color("colorTitle"))
                            .fontWeight(.bold).frame(maxWidth: .infinity,alignment: .leading).padding(.horizontal)
                        
                        
                        HStack{
                            //                            .foregroundColor(Color("healthbox"))
                            Image(systemName: ("\(levelimage)")).font(.system(size: 9))
                            
                            
                                .foregroundColor(Color("primary"))
                            
                            Text("\(level)")
                                .fontWeight(.medium)
                                .font(.system(size: 8))
                                .foregroundColor(Color("primary"))
                            
                        }.padding(.horizontal,7).padding(.vertical,4).background(Color("healthbox")).cornerRadius(50).frame(maxWidth: .infinity,alignment: .trailing)
                        
                        
                    }
                    VStack(alignment: .leading){
                    
                        Text("\(description)")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("fontblack"))
                            .modifier(Description()).frame(height: 100)
                        
                        Text("Equipment:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("colorTitle"))
                            .font(.system(size: 18))
                        
                        ForEach(equpment ,id: \.self){ eq in
                            Image("\(eq)")
                            
                            Text("\(eq)") .foregroundColor(Color("fontblack"))
                                .font(.system(size: 12))
                        }
                    }.padding()
                    
                    HStack{
                        
                        HStack{
                            Image(systemName: ("figure.run"))
                                .font(.system(size: 11,weight: .bold)).foregroundColor(.white)
                            Text("CoachMe")
                                .font(.system(size: 11 ,weight:.medium))
                                .foregroundColor(Color.white)
                            
                        }.frame(width: 165,height: 45).background(Color("primary")).cornerRadius(50).padding()
                        
                        HStack{
                            
                            
                            Image(systemName: ("heart")).font(.system(size: 11))
                                .foregroundColor(Color("primary"))
                            
                            Text("Add to favourite ")
                                .foregroundColor(Color("primary"))
                                .fontWeight(.medium)
                                .font(.system(size: 11))
                            
                        }.frame(width: 165,height: 42)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color("primary"))
                                
                            ).frame(maxWidth: .infinity)
                        
                        
                    }.frame(maxWidth: .infinity)
                    
                }.padding()
                
            }
      
        }
    }


struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
     DetailsPage(title: "Squat", description: "Mountain climbers are great for building cardio endurance, core strength, and agility. You work several different muscle groups with mountain climbers—it's almost like getting a total-body workout with just one exercise.", level: "Beginner", levelimage: "cellularbars", equpment: ["Yoga Matt"])
    }
}

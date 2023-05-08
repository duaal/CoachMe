//
//  onBoreading.swift
//  CoachMe
//
//  Created by duaa mohammed on 07/05/2023.
//

import SwiftUI

struct onBoreading: View {
    let info = pageInfo.all()
    @State var index = 0
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Skip").foregroundColor(Color("primary")).font(.system(size: 17 ,weight: .semibold)).padding(.horizontal,40).onTapGesture {
                    index = 2
                }.disabled(index == 2).opacity(index != 2 ? 1.0 : 0.0)}
            Spacer()
            Image(info[index].image)
            Text(info[index].title).foregroundColor(Color("primary")).font(.system(size: 34,weight: .bold)).padding(.bottom,20)
            Text(info[index].paragraph).font(.system(size: 17 ,weight: .regular)).multilineTextAlignment(.center).padding(.horizontal,30)
            Spacer()
            HStack{
                Text("Prev").foregroundColor(Color("primary")).font(.system(size: 17 ,weight: .semibold)).onTapGesture {
                 
                        
                            self.index = index - 1
                        
                        
                    
                }.disabled(index == 0).opacity(index == 0 ? 0.0  : 1.0).padding(.trailing,25)
                HStack{
                    
                    
                    RoundedRectangle(cornerRadius: 7)                .fill(index == 0 ? Color ("primary") : Color( "gray" ))
                        .frame(width: 53, height: 9)
                    RoundedRectangle(cornerRadius: 7)                .fill(index == 1 ? Color ("primary") : Color( "gray" ))
                        .frame(width: 53, height: 9)
                    RoundedRectangle(cornerRadius: 7)                .fill(index == 2 ? Color ("primary") : Color( "gray" ))
                        .frame(width: 53, height: 9)
                    
                    Text(index != 2 ? "Next" : "Start").foregroundColor(Color("primary")).font(.system(size: 17 ,weight: .semibold)).onTapGesture {
                      
                            if index != 2 {
                                self.index = index + 1
                                
                            
                        }}.padding(.leading,25)}
            }
        }
    }
    
    struct onBoreading_Previews: PreviewProvider {
        static var previews: some View {
            onBoreading()
        }
    }
    
}

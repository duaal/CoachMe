//
//  navDots.swift
//  CoachMe
//
//  Created by duaa mohammed on 07/05/2023.
//

import SwiftUI

struct navDots: View {
    @State var index :Int = 0
    var body: some View {
        HStack{
            
      
            RoundedRectangle(cornerRadius: 7)                .fill(index == 0 ? Color ("primary") : Color( "gray" ))
                .frame(width: 53, height: 9)
            RoundedRectangle(cornerRadius: 7)                .fill(index == 1 ? Color ("primary") : Color( "gray" ))
                .frame(width: 53, height: 9)
            RoundedRectangle(cornerRadius: 7)                .fill(index == 2 ? Color ("primary") : Color( "gray" ))
                .frame(width: 53, height: 9)
         
            }
        }
    }


struct navDots_Previews: PreviewProvider {
    static var previews: some View {
        navDots()
    }
}

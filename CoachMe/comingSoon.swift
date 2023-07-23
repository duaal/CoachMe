//
//  comingSoon.swift
//  CoachMe
//
//  Created by duaa mohammed on 11/06/2023.
//

import SwiftUI

struct comingSoon: View {
    var body: some View {
        ZStack{
            Image("ebg").resizable()
            VStack{
                Text("Coming Soon").foregroundColor(.white).font(.system(size: 50,weight: .bold
                                                                        ))
            }
            
        }.frame(maxWidth: .infinity , maxHeight: .infinity).ignoresSafeArea()
    }
}

struct comingSoon_Previews: PreviewProvider {
    static var previews: some View {
        comingSoon()
    }
}

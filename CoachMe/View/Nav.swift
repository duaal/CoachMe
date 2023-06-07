//
//  Nav.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//

import SwiftUI

struct Nav: View {
    @State var index : Int = 0
    var body: some View {
        VStack{
            if index == 0 {
                Main()
            }
            else if index == 1 {
                HealthLog()
            }
            else
            {
                Fav()
            }
            Spacer()
            HStack{
                VStack{ Image(systemName: "figure.disc.sports").modifier(Navimage())
                    Text("Workout").modifier(Navfont())}.foregroundColor(index == 0 ? Color("primary") : Color("grayText")) .frame(maxWidth: .infinity).onTapGesture {
                        self.index = 0
                    }
                VStack{Image(systemName: "bolt.fill").modifier(Navimage())
                    Text("Health log").modifier(Navfont())}.foregroundColor(index == 1 ? Color("primary") : Color("grayText")) .frame(maxWidth: .infinity).onTapGesture {
                        self.index = 1
                    }
                VStack{Image(systemName: "heart.fill").modifier(Navimage())
                    Text("Favourite").modifier(Navfont())}.foregroundColor(index == 2 ? Color("primary") : Color("grayText")) .frame(maxWidth: .infinity).onTapGesture {
                        self.index = 2
                    }
            }
            
        }    }
}

struct Nav_Previews: PreviewProvider {
    static var previews: some View {
        Nav()
    }
}

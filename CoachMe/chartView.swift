//
//  chartView.swift
//  CoachMe
//
//  Created by duaa mohammed on 10/05/2023.
//

import SwiftUI
import Charts

struct chartView: View {
    let currentWeek: [chartData] = [
            chartData(day: "sun", min: 42),
            chartData(day: "mon", min: 15),
            chartData(day: "tue", min: 28),
            chartData(day: "wed", min: 108),
            chartData(day: "thu", min: 53),
            chartData(day: "fri", min: 104),
            chartData(day: "sat", min: 40)
        ]
    var body: some View {
        VStack (alignment: .leading) {
         
            Text("Healt Log").modifier(MainTitle())
            Text("Steps For Today").modifier(SubTitle())
        
            
                Chart(currentWeek){
                    BarMark(
                        x: .value("week Days", $0.day ),
                        y: .value("Activites", $0.min)
                    )
                }.foregroundStyle(Color("primary"))
            }.frame(height: 400)
        }
    }

struct chartView_Previews: PreviewProvider {
    static var previews: some View {
        chartView()
    }
}

//
//  textModifier.swift
//  CoachMe
//
//  Created by duaa mohammed on 16/05/2023.
//
import SwiftUI
import Foundation
struct MainTitle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 28 ,weight: .bold)).foregroundColor(.black).padding(.horizontal,24).padding(.vertical,14).frame(maxWidth: .infinity, alignment: .leading)
           
    }
}
struct SubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size : 14 ,weight: .bold )).foregroundColor(Color("fontColor")).padding(.horizontal,24)
           
    }
}
struct SubTitle2: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size : 14 ,weight: .bold )).foregroundColor(Color("fontColor")).padding(.leading, 5)
           
    }
}
struct Title2: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size : 22 ,weight: .bold ))
           
    }
}
struct Tag: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size : 16 ,weight: .bold )).foregroundColor(Color("tagColor"))
           
    }
}
struct Bodyfont: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size : 17 ,weight: .regular )).foregroundColor(Color("tagColor"))
           
    }
}



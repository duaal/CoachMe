//
//  CoachMeApp.swift
//  CoachMe
//
//  Created by duaa mohammed on 07/05/2023.
//

import SwiftUI

@main
struct CoachMeApp: App {
    var body: some Scene {

        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                     let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
                
                splachScreen()
                
            
        }
    }
}

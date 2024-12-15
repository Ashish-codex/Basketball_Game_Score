//
//  BasketballGameApp.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import SwiftUI

@main
struct BasketballGameApp: App {
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                HomeView()
            })
        }
    }
}

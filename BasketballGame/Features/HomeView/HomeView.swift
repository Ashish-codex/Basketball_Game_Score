//
//  HomeView.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import SwiftUI

struct HomeView: View {
    
    var homeVM = HomeViewModel()
    
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack{
                
                TabBarSlider()
                
                List {
                    
                    ForEach(homeVM.modelScheduleData, id: \.uid) { scheduleItem in
                        ListCellView(scheduleItem: scheduleItem)
                    }
                    .listRowBackground(Color.black)
                    
            
                }
                .listStyle(.plain)
                
                
            }
        }
        .navigationTitle("Team")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SelectTeam()) {
                    Text("Select")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
            }
        })
        
        
    
        
    }
}

#Preview {
    NavigationView(content: {
        HomeView()
    })
    
}

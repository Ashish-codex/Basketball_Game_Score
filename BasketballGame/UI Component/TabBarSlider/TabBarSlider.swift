//
//  TabBarSlider.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import SwiftUI

struct TabBarSlider: View {
    
    var tabItems = ["Schedule", "Games"]
    @State var selectedTab = "Schedule"
    @Namespace var nameSpace
    
    var body: some View {
        HStack(alignment: .top){
            
            ForEach(tabItems, id: \.self) { currentTab in
                VStack{
                    Text(currentTab)
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth:.infinity)
                        
//                        .background(Color.pink)
                    
                    if(selectedTab==currentTab){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 1.5)
                            .foregroundStyle(.yellow)
                            .matchedGeometryEffect(id: "seleted", in: nameSpace)
                    }
                    
                    
                }
                .padding()
                .background(Color.black.opacity(0.001))
                .foregroundStyle( selectedTab==currentTab ? .white : .white.opacity(0.6))
                .onTapGesture {
                    selectedTab = currentTab
                }
                .animation(.smooth, value: selectedTab)
                
                
            }
            
        }
    }
}

#Preview {
    ZStack{
        Color.black
            .ignoresSafeArea()
        
        TabBarSlider()
    }
    
}

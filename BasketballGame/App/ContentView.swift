//
//  ContentView.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    
    let teamData = AppHelper.shared.sampleTeamData
    
    var body: some View {
    
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack{
                List {
                    ForEach(0..<10) { indx in
                        HStack{
                            VStack{
                                AsyncImage(
                                    url: URL(string: AppHelper.shared.sampleTeamData.logo)!) { image in
                                        image
                                            .resizable()
                                            .frame(width:30, height: 30)
                                        
                                    } placeholder: {
                                        Image(systemName: "photo.circle")
                                            .resizable()
                                            .frame(width:30, height: 30)
                                            .foregroundStyle(.white)
                                        
                                    }
                                
                                Text(AppHelper.shared.sampleTeamData.ta)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)

                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack{
                                Text("Name")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                Text(teamData?.tn ?? "-")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            
                            divider
                            
                            VStack{
                                Text("City")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                Text(teamData?.tc ?? "-")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            
                            divider
                            
                            VStack{
                                Text("State")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                
                                Text(teamData?.sta ?? "-")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            
                        }
                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.appGray)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .listRowBackground(Color.black)
                }
                .listStyle(.plain)
            }
        }
        
    }
    
    var divider: some View{
        VStack{
            Rectangle()
                .frame(width: 2.5, height: 28)
                 .foregroundStyle(Color(uiColor: UIColor(rgb: 0x55595D)))
        }
    }
    
}

#Preview {
    NavigationView(content: {
        ContentView()
    })
    
    
}

//
//  SelectTeam.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import SwiftUI

struct SelectTeam: View {
    
    @StateObject var selectedVM = SelectedViewModel()
    @Namespace var nameSpace
    
    
    var body: some View {
    
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack{
                
                SearchBar(searchText: $selectedVM.searchTeam, placeHolderTex: "Search by Team name, arena or city")
                    .padding()
                
                List {
                    
                    ForEach(selectedVM.teams, id: \.uid) { team in
                        teamCellView(teamItem: team)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(uiColor: UIColor(hex: team.color)!)],
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(alignment: .trailing) {
                            
                            if(selectedVM.selectedTeamName == team.tn){
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 8, height: 70)
                                     .foregroundStyle(Color.yellow)
                                     .offset(x: -2)
                                     .matchedGeometryEffect(id: "selected", in: nameSpace)
                            }
                            
                            
                                 
                        }
                        .onTapGesture {
                            selectedVM.onTap(team: team)
                        }
                        .animation(.smooth, value: selectedVM.selectedTeamName)
                    }
                    .listRowBackground(Color.black)
                    
//                    ForEach(0..<selectedVM.teams.count) { indx in
//                        
//                    }
//                    
//                    .listRowBackground(Color.black)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Select Team")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
    
    func teamCellView(teamItem: Team) -> some View{
        return HStack{
            
            // Team logo
            VStack{
                AsyncImage(
                    url: URL(string: teamItem.logo)!) { image in
                        image
                            .resizable()
                            .frame(width:30, height: 30)
                        
                    } placeholder: {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .frame(width:30, height: 30)
                            .foregroundStyle(.white)
                        
                    }
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            
                    )
                    .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 2)
                
                Text(teamItem.ta)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)

            }
            .frame(maxWidth: .infinity)
            
            
            // Team Name
            textWithTitleAndSubtitle(title: "Name", subTitle: teamItem.tn )
    
            divider
            
            // Team City
            textWithTitleAndSubtitle(title: "City", subTitle: teamItem.tc )
            
            
            divider
            
            // Team State
            textWithTitleAndSubtitle(title: "State", subTitle: teamItem.sta )
            
        }
    }
    
    var divider: some View{
        VStack{
            Rectangle()
                .frame(width: 1, height: 28)
                .foregroundStyle(.white.opacity(0.5))
//                 .foregroundStyle(Color(uiColor: UIColor(rgb: 0x55595D)))
        }
    }
    
    func textWithTitleAndSubtitle(title: String, subTitle: String) -> some View{
        
        return VStack{
            Text(title)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(.white)
            
            Text(subTitle)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        
    }
    
    
}

#Preview {
    NavigationView(content: {
        SelectTeam()
    })
    
}

//
//  CellView.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import SwiftUI

struct ListCellView: View {
    
    var scheduleItem: Schedule
    var cellVM:CellViewModel

    init(scheduleItem: Schedule) {
        self.scheduleItem = scheduleItem
        cellVM = CellViewModel(currentScheduleData: self.scheduleItem)
    }
    
    
    var body: some View {
        VStack {
            
            //Header text
            HStack{
                headerText(text: cellVM.showHome)
                divider
                    
                headerText(text: cellVM.scheduleDate)
                divider
                
                headerText(text: cellVM.scheduletime)
            }
            
            //Schedule Game
            HStack{
                
                //Visitor side
                teamSide(teamName: scheduleItem.v.ta, teamLogo: cellVM.visitorTeamLogo)
    
                
                //Scroce
                VStack{
                    
                    if(scheduleItem.st == 2){
                        VStack{
                            Text("Live")
                                .textCase(.uppercase)
                                .font(.system(size: 13))
                                .fontWeight(.medium)
                                .frame(width: 48, height: 30)
                                .foregroundStyle(.white)
                                .background(Color.cellBackgroundDark)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                        }
                    }
                    
                        
                    
                    HStack(spacing: 12){
                        Text("100")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text(cellVM.showVS)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white.opacity(0.8))
                        
                        Text("100")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                        
                }
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                
        
                
                
                //Home side
                teamSide(teamName: scheduleItem.h.ta, teamLogo: cellVM.homeTeamLogo)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color(uiColor: UIColor(hex: cellVM.visitorTeamColor)!), Color(uiColor: UIColor(hex: cellVM.homeTeamColor)!)],
                startPoint: .leading,
                endPoint: .trailing)
        )
//        .background(Color.cellBackgroundLight)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear(perform: {
            cellVM.checkAppTeamWithHomeAndVisitor()
        })
    }
    
    
    
    
    func teamSide(teamName: String, teamLogo: String)->some View{
        return VStack{
            
            AsyncImage(
                url: URL(string: teamLogo)!) { image in
                    image
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(6)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                
                        )
                        .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 2)
                    
                } placeholder: {
                    Image(systemName: "photo.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(.white)
                    
                }

            
            Text(teamName)
                .textCase(.uppercase)
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
    }
    
    
    func headerText(text:String)->some View{
        return Text(text)
            .textCase(.uppercase)
            .font(.caption2)
            .fontWeight(.medium)
            .foregroundStyle(.white)
    }
    
    
    var divider: some View{
        VStack{
            Rectangle()
                .frame(width: 1, height: 16)
                 .foregroundStyle(.white)
        }
    }
    
}

#Preview {
    ListCellView(scheduleItem: AppHelper.shared.sampleScheduleData)
    
}

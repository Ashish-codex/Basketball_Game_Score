//
//  CellViewModel.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation


class CellViewModel: ObservableObject{
    
    private var homeVM: HomeViewModel!
    var currentScheduleData:Schedule!
    var homeTeamLogo: String = ""
    var homeTeamColor: String = ""
    var visitorTeamLogo: String = ""
    var visitorTeamColor: String = ""
    var scheduleDate : String = ""
    var scheduletime : String = ""
    @Published var showVS : String = ""
    @Published var showHome : String = ""
    
    
    init(){}
    
    init(currentScheduleData:Schedule){
        homeVM = HomeViewModel()
        self.currentScheduleData = currentScheduleData
        getTeamsLogo(scheduleDataItem: currentScheduleData)
        getDateAndTime()
        checkAppTeamWithHomeAndVisitor()
        
        
    }
    
    
    // This will fetch the team logo
    func getTeamsLogo(scheduleDataItem:Schedule){
        
        for team in homeVM.modelTeamsData{
            
            if (scheduleDataItem.h.tid == team.tid){
                homeTeamLogo = team.logo
                homeTeamColor = team.color
            }
            
            if(scheduleDataItem.v.tid == team.tid){
                visitorTeamLogo = team.logo
                visitorTeamColor = team.color
            }
        }
        
    }
    
    
    
    // This will fomate this "2025-03-23T22:00:00.000Z" to "Thursday, 3 April 2025, 5:00 AM"
    func getDateAndTime(){
        
        let scheduleDateTime = currentScheduleData.gametime
        
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        
        if let date = inputFormatter.date(from: scheduleDateTime) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEEE, d MMMM yyyy, h:mm a"
            outputFormatter.locale = Locale(identifier: "en_US")

            
            let formattedDate = outputFormatter.string(from: date)
            let splittedDate = formattedDate.split(separator: ",")
            
            let date = "\(splittedDate[1].split(separator: " ")[0])"
            let month = "\(splittedDate[1].split(separator: " ")[1].prefix(3).uppercased())"
            let day = "\(splittedDate[0].prefix(3).uppercased())"
            
            self.scheduleDate = "\(day) \(month) \(date)"
            self.scheduletime = "\(splittedDate[2])"
            
//            print(formattedDate)
        } else {
            print("Invalid date string")
        }
        
    }
    
    
    func checkAppTeamWithHomeAndVisitor(){
        
        if (AppHelper.shared.appTeamName == currentScheduleData.h.tn){
            showVS = "VS"
            showHome = "Home"
        }else{
            showVS = "@"
            showHome = "Away"
        }
        
    }
}

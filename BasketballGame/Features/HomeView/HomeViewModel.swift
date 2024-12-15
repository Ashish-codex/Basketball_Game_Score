//
//  HomeViewModel.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    
    @Published var modelScheduleData: [Schedule] = []
    @Published var modelTeamsData: [Team] = []
    var homeTeamLogo: String = ""
    var visitorTeamLogo: String = ""
    
//    @Published var shedules: [Schedule]!
    
    init(){

        fetchData()
                
        if(AppHelper.shared.appTeamName == ""){
            AppHelper.shared.appTeamName = modelTeamsData.first?.tn ?? ""
        }
        
    }
    
    
    // This is generic fuction that will load the static json file data into ModelType data
    private func loadJsonData<T:Codable>(modelType: T.Type, fileName:String) -> T?{
        
        do {
            
            guard let path = Bundle.main.path(forResource: fileName, ofType: ".txt") else{
                print("Failed: Path doesn't exist")
                return nil
            }
            
            guard let data = try String(contentsOfFile: path).data(using: .utf8) else{
                print("Failed: Can not read from file path to data")
                return nil
            }
        
            let modelData = try JSONDecoder().decode(modelType, from: data)
            
//            print("Model Data = \(modelData)")
            
            return modelData
            
        } catch let err {
            print("Catch Error: \(err.localizedDescription)")
            
        }
        
        return nil
        
    }
    
    
    private func fetchData(){
        
        guard let scheduleData = loadJsonData(modelType: ModelScheduleData.self, fileName: "Schedule") else {
            return
        }
        
        guard let teamsData = loadJsonData(modelType: ModelTeamData.self, fileName: "Teams") else {
            return
        }
        
        
        modelScheduleData = scheduleData.data.schedules
        modelTeamsData = teamsData.data.teams
        
    }
    
}

//
//  SelectedViewModel.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation
import SwiftUI
import Combine

class SelectedViewModel: ObservableObject{
    
    private var homeVM: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    @Published var teams: [Team]
    @Published var selectedTeamName: String
    @Published var searchTeam = ""
    
    
    init(){
        
        homeVM = HomeViewModel()
        teams = homeVM.modelTeamsData
        
        selectedTeamName = AppHelper.shared.appTeamName
        addSubscribers()
    }
    
    
    func onTap(team: Team){
        selectedTeamName = team.tn
        AppHelper.shared.appTeamName = selectedTeamName
        
    }
    
    
    func addSubscribers(){
        $searchTeam
            .sink {[weak self] returnText in
                
                
                guard !returnText.isEmpty else {
                    self?.teams = self?.homeVM.modelTeamsData ?? []
                    return
                }
                                
                self?.teams = self?.teams.filter({ team in
                    return team.tn.localizedCaseInsensitiveContains(returnText) || team.ta.localizedCaseInsensitiveContains(returnText) || team.tc.localizedCaseInsensitiveContains(returnText)
                }) ?? []
                

                
            }
            .store(in: &cancellables)
    }
}

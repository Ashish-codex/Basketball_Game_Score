//
//  AppHelper.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation

class AppHelper{
    
    public static let shared = AppHelper()
    var sampleScheduleData:Schedule!
    var sampleTeamData:Team!
    var appTeamName = ""
    
    private init(){
        loadData()
    }
    
    private func loadData(){
        sampleScheduleData = Schedule(
            uid: "dfed7fbddcc57247533bfdf3d75",
            year: 2024,
            leagueID: "00",
            seasonID: "02",
            h: H(tid: "1610612748", re: "12-10", ta: "MIA", tn: "Heat", tc: "Miami", s: "0", istGroup: nil),
            v: H(tid: "1610612764", re: "3-19", ta: "WAS", tn: "Wizards", tc: "Washington", s: "0", istGroup: nil),
            gid: "0022401190",
            gcode: "20250413/WASMIA",
            buyTicket: "0D00610E170A5D28",
            bd: Bd(b: []),
            seri: "",
            isGameNecessary: "1",
            gametime: "2025-04-13T17:00:00.000Z",
            cl: nil,
            arenaName: "Kaseya Center",
            arenaCity: "Miami",
            arenaState: "FL",
            st: 1,
            stt: "1:00 pm ET",
            ppdst: .i,
            buyTicketURL: "",
            logoURL: nil,
            hide: false,
            gameState: .active,
            gameSubtype: nil,
            customFields: nil,
            templateFields: nil,
            csCustomFields: nil
        )
        
        sampleTeamData = Team(
            uid: "dfe4f5a5c5401b9ed01b68045c2",
            year: 2024,
            leagueID: "00",
            seasonID: "02",
            istGroup: "East Group C",
            tid: "1610612764",
            tn: "Wizards",
            ta: "WAS",
            tc: "Washington",
            di: "Southeast",
            co: .east,
            sta: "DC",
            logo: "https://images.contentstack.io/v3/assets/bltf0f8f301b0c60428/bltf48fd9b4465078e5/636ccf09796f9a184cc02257/download",
            color: "E31837",
            customFields: nil,
            templateFields: nil
        )
    }
    
}

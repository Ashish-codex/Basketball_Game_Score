//
//  SearchBar.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 15/12/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText:String
    let placeHolderTex:String
    
    var body: some View {
        HStack{
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundStyle(.white)
            
            TextField(text: $searchText) {
                Text(placeHolderTex)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.45))
            }
            .foregroundStyle(.white)
            .padding(.leading, 8)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.cellBackgroundDark)
                .shadow(
                    color: .white.opacity(0.2),
                    radius: 10,
                    x: 0,
                    y: 6
                )
        )
        .overlay(alignment: .trailing) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundStyle(.white)
                .padding()
                .padding(.trailing, 6)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    searchText = ""
                    UIApplication.shared.endEditingKeyboard() 
                }
                
                
                
        }
    }
}

#Preview {
    ZStack{
        Color.black
            .ignoresSafeArea()
    
//        SearchBar(searchText: "", placeHolderTex: "search here")
        SearchBar(searchText: .constant(""), placeHolderTex: "Search here")
    }
    
}

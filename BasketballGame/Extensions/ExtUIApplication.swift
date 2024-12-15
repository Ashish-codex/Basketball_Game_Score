//
//  ExtUIApplication.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 15/12/24.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditingKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

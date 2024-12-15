//
//  ExtUIImage.swift
//  BasketballGame
//
//  Created by Ashish Prajapati on 14/12/24.
//

import Foundation
import SwiftUI



extension Image{
    
    func loadUrlImage(){
        
    }
}



extension UIImageView{
    
    func loadImageUrl(url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
          if let data = try? Data(contentsOf: url, options: .uncached) {
              if let image = UIImage(data: data) {
                  DispatchQueue.main.async {
                      self?.image = image
                  }
              }
          }
          else{
              print("Failed to load image")
              DispatchQueue.main.async {
                  self?.image = UIImage(named: "img_photo_placeholder")
              }
              
          }
       }
     }
}

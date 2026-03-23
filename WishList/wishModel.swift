//
//  wishModel.swift
//  WishList
//
//  Created by Disha Limbani on 2026-03-17.
//

import Foundation
import SwiftData

@Model
class Wish: Identifiable {
    
    var title: String
    
   
    
    init(title: String){
       
        self.title = title
       
       
    }
}

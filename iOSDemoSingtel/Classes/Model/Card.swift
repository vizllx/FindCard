//
//  Card.swift
//  iOSDemoSingtel
//
//  Created by Sandeep Mukherjee on 24/04/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import Foundation

struct Card {
    // MARK: - Properties
    var cardIndexpath: IndexPath?
    var value : String = ""
    var flipped : Bool = false
    
    // MARK: - Init
    init(value: String){
        self.value = value
        self.flipped = false
        cardIndexpath = IndexPath()
    }
    
    init(value: String , indexpath:IndexPath){
        self.value = value
        self.flipped = true
        cardIndexpath = indexpath
    }
    
}

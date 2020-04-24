//
//  Helper.swift
//  iOSDemoSingtel
//
//  Created by Sandeep Mukherjee on 24/04/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import Foundation
class Helper {
    
    static func random(digits:Int) -> String {
           var number = String()
           for _ in 1...digits {
               number += "\(Int.random(in: 1...9))"
           }
           return number
       }
}

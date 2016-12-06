//
//  TaxType.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

enum TaxType: String{
    
    case FED = "fedtax"
    
    case CA = "CA"
    case MA = "MA"
    case NY = "NY"
    case WA = "WA"
    
    case TEST = "TestTax"
    
    static let all = [FED, CA, MA, WA]
    
    static let states = [CA.rawValue, MA.rawValue, NY.rawValue, WA.rawValue]
    
    static let test = [TEST]

}


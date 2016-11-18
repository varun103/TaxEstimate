//
//  TaxType.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

enum TaxType: String{
    
    case FED = "fedTax"
    
    case CA = "CATax"
    
    case TEST = "TestTax"
    
    static let all = [FED, CA]
    
    static let states = [CA]
    
    static let test = [TEST]

}


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
    case STATE = "state"
    
    case AL = "AL"
    case AK = "AK"
    case CA = "CA"
    case FL = "FL"
    case IL = "IL"
    case IN = "IN"
    case MA = "MA"
    case NY = "NY"
    case WA = "WA"
    
    case MED = "medicare"
    case SS = "socical security"
    
    case TEST = "TestTax"
    
    static let all = [FED, AL, AK, CA, FL, IL, IN, MA, NY, WA]
    
    static let states = [AL.rawValue, AK.rawValue, CA.rawValue, FL.rawValue, IL.rawValue, IN.rawValue, MA.rawValue, NY.rawValue, WA.rawValue]
    
    static let test = [TEST]
    

}


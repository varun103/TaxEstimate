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
    case CO = "CO"
    case FL = "FL"
    case IL = "IL"
    case IN = "IN"
    case KS = "KS"
    case MA = "MA"
    case MI = "MI"
    case NV = "NV"
    case NY = "NY"
    case WA = "WA"
    
    case MED = "medicare"
    case SS = "socical security"
    
    case LONG_TERM = "longTerm"
    
    case TEST = "TestTax"
    
    static let all = [FED, AL, AK, CA, CO, FL, IL, IN, KS, MA, MI, NV, NY, WA, LONG_TERM]
    
    static let states = [AL.rawValue, AK.rawValue, CA.rawValue, CO.rawValue,
                         FL.rawValue, IL.rawValue, IN.rawValue, KS.rawValue,
                         MA.rawValue, MI.rawValue, NV.rawValue, NY.rawValue, WA.rawValue]
    
    static let test = [TEST]

}


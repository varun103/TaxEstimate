//
//  UserProtocol.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


protocol UserProtocol {
    
    var initialIncome: Double {set get}
    
    var status: FilingStatusEnum {get}
    
    var taxBracket: Bracket {get}
    
    var taxableIncome: Double {get set}
    
    func getFederalTax() -> Int
    
    func getStateTax() -> Int
}

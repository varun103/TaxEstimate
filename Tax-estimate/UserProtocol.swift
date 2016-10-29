//
//  UserProtocol.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


protocol UserProtocol {
    
    var income: Double {get}
    
    var status: FilingStatus {get}
    
    var taxBracket: TaxBracket {get}
    
}
//
//  FilingStatus.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


enum FilingStatusEnum :String{
    
    case single = "SINGLE"
    
    case married = "MARRIED FILING JOINTLY"
    
    case head = "HEAD OF HOUSEHOLD"
    
    case married_s = "MARRIED FILING SEPARATE"
    
    static func allValues() -> [String]{
        return [single.rawValue, married_s.rawValue, married.rawValue, head.rawValue]
    }
    
}

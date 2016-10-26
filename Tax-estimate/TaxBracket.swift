//
//  TaxBracket.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/25/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

class TaxBracket{
    
    let bracket: Int;
    
    var startRange: Int;
    
    var endRange: Int?;
    
    var percentage: Float;
    
    
    init(bracket:Int, startRange:Int, endRange:Int){
        self.bracket = bracket
        self.startRange = startRange
        self.endRange = endRange
        self.percentage = TaxBracket.calcBracket(self.bracket)
    }
    
    
    func getTaxForFullRange() -> Float{
        if self.endRange != nil{
            return Float(self.endRange! - self.startRange) * self.percentage
        }else
        {
            return 0.0
        }
    }
    
    class func calcBracket(_bracket:Int) -> Float{
        return Float(_bracket) * 0.01
    }
    
}
//
//  CapitalGains.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/27/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit


class CapitalGains {
    
    private(set) var shortTermGains:Int
    
    private(set) var longTermGains:Int
    
    init(shortTerm:Int, longTerm:Int) {
        self.shortTermGains = shortTerm
        self.longTermGains = longTerm
    }
    
    convenience init(){
        self.init(shortTerm: 0, longTerm: 0)
    }
    
    /// Needed for calculating long term capital gains tax
    var effectiveLongTerm : Int {
        var _effectivelongTermGain:Int
        if (self.longTermGains < self.net) {
            _effectivelongTermGain =  self.longTermGains
        } else {
            _effectivelongTermGain = self.net
        }
        
        if (_effectivelongTermGain < 0) {
            return 0
        }
        return _effectivelongTermGain
    }
    
    var net : Int {
        let _net = self.shortTermGains + self.longTermGains
        if _net < Settings.MAX_DEDUCTIBLE_LOSS {
            return Settings.MAX_DEDUCTIBLE_LOSS
        }
        return _net
    }
}


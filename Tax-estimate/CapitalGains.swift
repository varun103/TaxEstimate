//
//  CapitalGains.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/27/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

protocol CapitalGainsDelegate {
    
    func amountChanged()
}


class CapitalGains {
    
    private(set) var shortTermGains:Int
    private(set) var longTermGains:Int
    
    private var status: FilingStatusEnum?
    
    var delegate: CapitalGainsDelegate?
    
    init(shortTerm:Int, longTerm:Int) {
        self.shortTermGains = shortTerm
        self.longTermGains = longTerm
    }
    
    convenience init(){
        self.init(shortTerm: 0, longTerm: 0)
    }
    
    /// Effective long term capital gains
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
    
    /// Effective short term amount
    var effectiveShortTerm: Int {
        var _effectiveShortTermGain: Int
        if (self.net < 0){
            return 0
        }
        _effectiveShortTermGain = self.net - self.longTermGains
        
        if (_effectiveShortTermGain < 0) {
            return 0
        }
        return _effectiveShortTermGain
    }
    
    /// Combined amount ->
    /// capped on the lower end at max deductible loss amount (-3000)
    func net(status:FilingStatusEnum) -> Int {
        var _maxDeductible = Settings.MAX_DEDUCTIBLE_LOSS
        if (status == FilingStatusEnum.married_s){
            _maxDeductible = (_maxDeductible/2)
        }
        let _net = self.shortTermGains + self.longTermGains
        if _net < _maxDeductible {
            return _maxDeductible
        }
        return _net
    }
    
    
    var absoluteNet : Int {
        return self.shortTermGains + self.longTermGains
    }
    
    /// Combined amount ->
    /// capped on the lower end at max deductible loss amount (-3000)
    private var net : Int {
        let _net = self.shortTermGains + self.longTermGains
        if _net < Settings.MAX_DEDUCTIBLE_LOSS {
            return Settings.MAX_DEDUCTIBLE_LOSS
        }
        return _net
    }

        
    func setShortTermGains(amount:Int) {
        self.shortTermGains = amount
        delegate?.amountChanged()
    }
    
    func setLongTermGains(amount:Int) {
        self.longTermGains = amount
        delegate?.amountChanged()
    }
}



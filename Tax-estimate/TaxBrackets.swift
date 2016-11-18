//
//  TaxBrackets.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/17/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class TaxBrackets {
    
    private var brackets:[Bracket]
    
    init(brackets:[Bracket]){
        self.brackets = brackets
    }
    
    convenience init(){
        let _temp: [Bracket] = []
        self.init(brackets:_temp)
    }
    func add(bracket: Bracket){
        self.brackets.append(bracket)
    }
    
    func get() ->  [Bracket]{
        return self.brackets
    }
    
    func getBracket(income:Double ) -> Bracket {
        
        var _fit:Bracket?
        
        for bracket:Bracket in self.brackets{
            if let bracketMax = bracket.getMax(){
                if income < bracketMax {
                    _fit = bracket
                    break
                } else{
                    continue
                }
            } else{
                _fit = bracket
            }
        }
        return _fit!
    }
    
}

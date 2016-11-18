//
//  TaxBracketsProtocol.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

protocol TaxBracketsProtocol {

    func getTaxBrackets() ->  [FilingStatusEnum: [TaxType: [Bracket]]]
    
    func forFed(filingStatus: FilingStatusEnum) -> [Bracket]
    
    func forState(state: TaxType, filingStatus: FilingStatusEnum) -> [Bracket]
}

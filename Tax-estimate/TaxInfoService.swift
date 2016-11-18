//
//  TaxBracketsProtocol.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

protocol TaxInfoService {

    /// Returns the entire catalogue of tax brackets for all types
    ///
    /// - Returns: <#return value description#>
    func getCatalogue() ->  [FilingStatusEnum: [TaxType: TaxBrackets]]
    
    
    /// Returns TaxBrackets for Fed for the provided filing status
    ///
    /// - Parameter filingStatus: <#filingStatus description#>
    /// - Returns: <#return value description#>
    func getFedBrackets(_ filingStatus: FilingStatusEnum) -> TaxBrackets
    
 
    /// Return TaxBrackets for the provided state and filing status
    ///
    /// - Parameters:
    ///   - state: <#state description#>
    ///   - filingStatus: <#filingStatus description#>
    /// - Returns: <#return value description#>
    func getStateBrackets(_ state: TaxType, filingStatus: FilingStatusEnum) -> TaxBrackets
}

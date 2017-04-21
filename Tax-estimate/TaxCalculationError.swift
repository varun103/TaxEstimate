//
//  TaxCalculationError.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/27/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

enum TaxCalculationError: Error{
    
    case outOfTaxBracket
    
    case catalogueProcessingError
    
}

enum UserInputError: Error {
   
    case deductionAmountExceedError

}


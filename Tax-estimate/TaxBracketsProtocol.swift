//
//  TaxBracketsProtocol.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 10/29/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit

protocol TaxBracketsProtocol {

    func getTaxBracketForUser(user: UserProtocol) -> Bracket?
}

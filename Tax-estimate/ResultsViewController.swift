//
//  ResultsViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/30/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    private final let _fedTax = "Fed Tax"
    private final let _stateTax = "StateTax"
    
    private final let _fedBracket = "Fed Bracket"
    private final let _stateBracket = "State Bracket"

    private final let _contribution401 = "401k Conribution"
    private final let _takeHomeIncome = "Take Home Income"
    private final let _overallIncome = "Overall Income"
    
    private final let textCellIdentifier = "resultCell"
    
    @IBOutlet weak var fedTax: UILabel!
    @IBOutlet weak var stateTax: UILabel!
    @IBOutlet weak var contribution401: UILabel!
    @IBOutlet weak var takeHomeIncome: UILabel!
    @IBOutlet weak var overallIncome: UILabel!
    
    
    
    var user: User?
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        
        self.result.text = String(format:"%f",user!.getIncome())
    }
    
 }

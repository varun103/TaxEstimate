//
//  ResultsViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/30/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    
    private final let textCellIdentifier = "resultCell"
    
    @IBOutlet weak var fedTax: UILabel!
    @IBOutlet weak var stateTax: UILabel!
    @IBOutlet weak var contribution401: UILabel!
    @IBOutlet weak var takeHomeIncome: UILabel!
    @IBOutlet weak var overallIncome: UILabel!
    
    @IBOutlet weak var fedTaxAmount: UILabel!
    @IBOutlet weak var stateTaxAmount: UILabel!
    @IBOutlet weak var contributionAmount: UILabel!
    @IBOutlet weak var overallIncomeAmount: UILabel!
    @IBOutlet weak var takeHomeIncomeAmount: UILabel!
    
    
    var user: User?
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        
        self.result.text = String(format:"%f",user!.getIncome())
        self.fedTaxAmount.text = Config.addCommasToNumber(number: (user?.getFederalTax())!)

    }
    
 }

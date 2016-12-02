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
    
    private var resultsMap:[String:Double] = [:]
    
    
    var user: User?
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        
        initializeResultMap()
        
        self.result.text = String(format:"%f",user!.getIncome())
    }
    
    private func initializeResultMap() {
        self.resultsMap[_fedTax] = 0.0
        self.resultsMap[_stateTax] = 0.0
        self.resultsMap[_fedBracket] = 0.0
        self.resultsMap[_stateBracket] = 0.0
        self.resultsMap[_contribution401] = 0.0
        self.resultsMap[_takeHomeIncome] = 0.0
        self.resultsMap[_overallIncome] = 0.0

    }
 }

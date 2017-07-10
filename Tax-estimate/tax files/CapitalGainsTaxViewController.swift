//
//  CapitalGainsTaxViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 6/15/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit

class CapitalGainsTaxViewController: UIViewController {
    
    private var screenTitle:String = "Tax on Capital Gains"
    
    private let netCapitalLoss = "Net Capital Loss"
    private let capitalLossDeduction = "Deductible Capital Loss"
    
    var user: User?
    
    @IBOutlet weak var netCapitalGainsLabel: UILabel!
    @IBOutlet weak var netCapitalGains: UIButton!
    @IBOutlet weak var longTermGains: UIButton!
    
    @IBOutlet weak var longTermGainsFedTax: UILabel!
    @IBOutlet weak var totalFederalCapitalGainsTax: UILabel!
    
    @IBOutlet weak var shortTermGains: UIButton!
    @IBOutlet weak var shortTermGainsFedTax: UILabel!
    
    @IBOutlet weak var totalFederalCapitalGainTaxLabel: UILabel!
    
    override func viewDidLoad() {
        
        self.navigationItem.title = screenTitle
        
        let netCapitalGains = user?.capitalGains.absoluteNet
        
        if (netCapitalGains! < 0) {
            self.netCapitalGainsLabel.text = netCapitalLoss
            self.netCapitalGains.setTitle(Config.addCommasToNumber(number: (user?.capitalGains.absoluteNet)!), for: UIControlState.normal)
            self.totalFederalCapitalGainTaxLabel.text = capitalLossDeduction
            self.totalFederalCapitalGainsTax.text = Config.addCommasToNumber(number: (user?.capitalGains.net(status: (user?.status)!))!)
        } else {
            self.netCapitalGains.setTitle(Config.addCommasToNumber(number: (user?.capitalGains.net(status: (user?.status)!))!), for: UIControlState.normal)
            self.totalFederalCapitalGainsTax.text = Config.addCommasToNumber(number: (user?.fedTax.longTermCapitalGainsTax())! + (user?.fedTax.shortTermCapitalGainsTax())!)
        }
        self.shortTermGains.setTitle(Config.addCommasToNumber(number: (user?.capitalGains.effectiveShortTerm)!), for: UIControlState.normal)
        self.shortTermGainsFedTax.text = Config.addCommasToNumber(number:(user?.fedTax.shortTermCapitalGainsTax())!)
        
        self.longTermGains.setTitle( Config.addCommasToNumber(number: (user?.capitalGains.effectiveLongTerm)!), for: UIControlState.normal)
        self.longTermGainsFedTax.text = Config.addCommasToNumber(number:(user?.fedTax.longTermCapitalGainsTax())!)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultsPage = segue.destination as? TaxBracketViewController {
            resultsPage.user = self.user
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
}

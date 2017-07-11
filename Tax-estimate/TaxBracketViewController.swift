//
//  TaxBracketViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 4/14/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TaxBracketViewController: UIViewController, GADBannerViewDelegate {
    
    let screenTitle = "Tax Summary"
    
    var user:User?
    
    @IBOutlet weak var income: UILabel!
    
    @IBOutlet weak var preTaxDeductions: UILabel!
    @IBOutlet weak var capitalGains: UILabel!
    @IBOutlet weak var taxableIncome: UILabel!
    @IBOutlet weak var fedTax: UILabel!
    @IBOutlet weak var fedTaxBracket: UILabel!
    @IBOutlet weak var stateTax: UILabel!
    @IBOutlet weak var stateTaxBracket: UILabel!
    
    @IBOutlet weak var adsBannerView: GADBannerView!
    
    override func viewDidLoad() {
        
        self.navigationItem.title = self.screenTitle
        income.text = Config.addCommasToNumber(number: Int((user?.initialIncome)!))
        preTaxDeductions.text = Config.addCommasToNumber(number: Int((user?.preTaxDeductions.getAmount())!))
        capitalGains.text = Config.addCommasToNumber(number: (user?.capitalGains.net(status: (user?.status)!))!)
        taxableIncome.text = Config.addCommasToNumber(number: Int((user?.getTaxableIncome())!))
        fedTax.text = Config.addCommasToNumber(number: (user?.getFederalTax())!)
        stateTax.text = Config.addCommasToNumber(number: (user?.getStateTax())!)
        fedTaxBracket.text = doubleToString(value: (user?.fedTax.getBracket().getRate())!) + "%"
        stateTaxBracket.text = doubleToString(value: (user?.stateTax.getBracket().getRate())!) + "%"
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adsBannerView.delegate = self
        adsBannerView.adUnitID = "ca-app-pub-1253615041445374/5188157448"
        adsBannerView.rootViewController = self
        adsBannerView.load(request)

    }
    
    private func doubleToString(value:Double) -> String {
        return String(format:"%.2f",value)
    }
    
    
    
}

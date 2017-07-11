//
//  CapitalGainsTaxViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 6/15/17.
//  Copyright © 2017 Varun Ajmera. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CapitalGainsTaxViewController: UIViewController, CGPopupViewControllerDelegate, GADBannerViewDelegate {
    
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
    
    @IBOutlet weak var adsBannerView: GADBannerView!
    override func viewDidLoad() {
        
        self.navigationItem.title = screenTitle
        
        self.netCapitalGains.layer.cornerRadius = 10.0
        
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
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adsBannerView.delegate = self
        adsBannerView.adUnitID = "ca-app-pub-1253615041445374/5188157448"
        adsBannerView.rootViewController = self
        adsBannerView.load(request)

        
    }
    
    @IBAction func resetCapitalGains(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cgPopupView") as!CGPopupViewController
        popUpVC.capitalGains = self.user?.capitalGains
        popUpVC.delegate = self
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    func valuesChanged() {
        viewDidLoad()
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

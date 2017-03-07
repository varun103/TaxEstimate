//
//  ResultsViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/30/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    private final let screenTitle:String = "Pre-Tax Contributions"
    private final let textCellIdentifier = "resultCell"

    @IBOutlet weak var taxSavings: UILabel!
    @IBOutlet weak var fedTaxSavings: UILabel!
    @IBOutlet weak var stateTaxSavings: UILabel!

    @IBOutlet weak var segmentSelector: UISegmentedControl!

    @IBOutlet weak var fourOOneKSlider: UISlider!
    @IBOutlet weak var contribution401: UILabel!
    @IBOutlet weak var spouse401KContribution: UILabel!

    @IBOutlet weak var fsaSlider: UISlider!
    @IBOutlet weak var fsaContributionAmount: UILabel!
    @IBOutlet weak var spouseFSAContribution: UILabel!

    
    private var fourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    private var spouseFourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    
    private var fsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    private var spouseFsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    
    var user: User?
    
    override func viewDidLoad() {
        
        self.navigationItem.title = self.screenTitle
        self.segmentSelector.isHidden = true
        
        if(user?.getStatus() == FilingStatusEnum.married) {
            spouseFourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
            spouseFsaPreTaxDeduction = FSAHealthPreTaxDeduction()
            self.segmentSelector.setTitleTextAttributes([NSFontAttributeName:Config.getAppFont(size: 16), NSForegroundColorAttributeName: UIColor.blue], for: UIControlState.normal)
            self.segmentSelector.isHidden = false
            user?.addPreTaxDeduction(deduction: spouseFsaPreTaxDeduction)
            user?.addPreTaxDeduction(deduction: spouseFourOOneKPreTaxDeduction)
        }
        user?.addPreTaxDeduction(deduction: fourOOneKPreTaxDeduction)
        user?.addPreTaxDeduction(deduction: fsaPreTaxDeduction)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        prepareContributionSlider()
    }
    
    @IBAction func fsaContributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            self.fsaPreTaxDeduction.contributionAmount = currentValue
            self.fsaContributionAmount.text = "\(currentValue)"
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.spouseFsaPreTaxDeduction.contributionAmount = currentValue
            self.spouseFSAContribution.text = "\(currentValue)"
        }
        calculateTaxSavings()
    }

    @IBAction func contributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            self.fourOOneKPreTaxDeduction.contributionAmount = currentValue
            self.contribution401.text = "\(currentValue)"
        }else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.spouseFourOOneKPreTaxDeduction.contributionAmount = currentValue
            self.spouse401KContribution.text = "\(currentValue)"
        }
        calculateTaxSavings()
    }
    
    private func prepareContributionSlider() {
        if(self.segmentSelector.selectedSegmentIndex == 0){
            self.fourOOneKSlider.setValue(Float(self.fourOOneKPreTaxDeduction.contributionAmount), animated: true)
            self.fsaSlider.setValue(Float(self.fsaPreTaxDeduction.contributionAmount), animated: true)
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.fourOOneKSlider.setValue(Float(self.spouseFourOOneKPreTaxDeduction.contributionAmount), animated: true)
            self.fsaSlider.setValue(Float(self.spouseFsaPreTaxDeduction.contributionAmount), animated: true)
        }
    }
    
   
    private func calculateTaxSavings(){
        self.taxSavings.text =   Config.addCommasToNumber(number: (user?.getTaxSavings())!)
        self.fedTaxSavings.text = Config.addCommasToNumber(number: (user?.getFedTaxSavings())!)
        self.stateTaxSavings.text = Config.addCommasToNumber(number: (user?.getStateTaxSavings())!)
    }
}

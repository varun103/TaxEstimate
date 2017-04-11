//
//  ResultsViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/30/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {
    
    private final let screenTitle:String = "View Savings"
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

    @IBOutlet weak var estimatedTaxSavings: UILabel!
    
    private var fourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    private var spouseFourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    
    private var fsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    private var spouseFsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    
    let shapeLayer = CAShapeLayer()

    var user: User?
    
    override func viewDidLoad() {
        
        self.navigationItem.title = self.screenTitle
        self.segmentSelector.isHidden = true
        
        if(user?.getStatus() == FilingStatusEnum.married) {
            
            self.segmentSelector.setTitleTextAttributes([NSFontAttributeName:Config.getAppFont(size: 14), NSForegroundColorAttributeName: UIColor(red: 111.0/255.0, green: 132.0/255.0, blue: 195.0/255.0, alpha: 255.0/255.0)], for: UIControlState.normal)
            self.segmentSelector.isHidden = false
            self.segmentSelector.layer.cornerRadius = 10.0
            self.segmentSelector.layer.borderColor = UIColor.white.cgColor
            self.segmentSelector.layer.borderWidth = 1.0;

            self.segmentSelector.layer.masksToBounds = true
            user?.addPreTaxDeduction(deduction: spouseFsaPreTaxDeduction)
            user?.addPreTaxDeduction(deduction: spouseFourOOneKPreTaxDeduction)
        }
        user?.addPreTaxDeduction(deduction: fourOOneKPreTaxDeduction)
        user?.addPreTaxDeduction(deduction: fsaPreTaxDeduction)
        setInitialValues()
        
        self.fourOOneKSlider.setThumbImage(UIImage(named:"scroller1.png"), for: UIControlState.normal)
        self.fsaSlider.setThumbImage(UIImage(named:"scroller1.png"), for: UIControlState.normal)

    }
    
    override func viewDidLayoutSubviews() {
        self.shapeLayer.frame = self.view.bounds
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        prepareContributionSlider()
    }
    
    @IBAction func fsaContributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            self.fsaPreTaxDeduction.setContributionAmount(amount: currentValue)
            self.fsaContributionAmount.text = Config.addCommasToNumber(number: currentValue)
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.spouseFsaPreTaxDeduction.setContributionAmount(amount: currentValue)
            self.spouseFSAContribution.text = Config.addCommasToNumber(number: currentValue)
        }
        calculateTaxSavings()
    }

    @IBAction func contributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            self.fourOOneKPreTaxDeduction.setContributionAmount(amount: currentValue)
            self.contribution401.text = Config.addCommasToNumber(number: currentValue)
        }else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.spouseFourOOneKPreTaxDeduction.setContributionAmount(amount: currentValue)
            self.spouse401KContribution.text = Config.addCommasToNumber(number: currentValue)
        }
        calculateTaxSavings()
    }
    
    private func prepareContributionSlider() {
        if(self.segmentSelector.selectedSegmentIndex == 0){
            self.fourOOneKSlider.setValue(Float(self.fourOOneKPreTaxDeduction.getContributionAmount()), animated: true)
            self.fourOOneKSlider.setThumbImage(UIImage(named:"scroller1.png"), for: UIControlState.normal)
            self.fourOOneKSlider.setMinimumTrackImage(UIImage(named:"Line2.png"), for: UIControlState.normal)

            self.fsaSlider.setValue(Float(self.fsaPreTaxDeduction.getContributionAmount()), animated: true)
            self.fsaSlider.setThumbImage(UIImage(named:"scroller1.png"), for: UIControlState.normal)
            self.fsaSlider.setMinimumTrackImage(UIImage(named:"Line2.png"), for: UIControlState.normal)

            self.enabledText(enable: false, labels: self.spouse401KContribution, self.spouseFSAContribution)
            self.enabledText(enable: true, labels: self.contribution401, self.fsaContributionAmount)
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.fourOOneKSlider.setValue(Float(self.spouseFourOOneKPreTaxDeduction.getContributionAmount()), animated: true)
            self.fourOOneKSlider.setThumbImage(UIImage(named:"Scroller3.png"), for: UIControlState.normal)
            self.fourOOneKSlider.setMinimumTrackImage(UIImage(named:"Line1.png"), for: UIControlState.normal)

            self.fsaSlider.setValue(Float(self.spouseFsaPreTaxDeduction.getContributionAmount()), animated: true)
            self.fsaSlider.setThumbImage(UIImage(named:"Scroller3.png"), for: UIControlState.normal)
            self.fsaSlider.setMinimumTrackImage(UIImage(named:"Line1.png"), for: UIControlState.normal)

            self.enabledText(enable: true, labels: self.spouse401KContribution, self.spouseFSAContribution)
            self.enabledText(enable: false, labels: self.contribution401, self.fsaContributionAmount)
        }
    }
    
    private func setInitialValues(){
        self.fsaContributionAmount.text = Config.addCommasToNumber(number: 0)
        self.contribution401.text = Config.addCommasToNumber(number: 0)
        self.taxSavings.text =   Config.addCommasToNumber(number: 0)
        self.estimatedTaxSavings.text = Config.addCommasToNumber(number: 0)

    }
    
    private func calculateTaxSavings(){
        self.taxSavings.text =   Config.addCommasToNumber(number: (user?.getTaxSavings())!)
        self.estimatedTaxSavings.text =   Config.addCommasToNumber(number: (user?.getTaxSavings())!)
        self.fedTaxSavings.text = Config.addCommasToNumber(number: (user?.getFedTaxSavings())!)
        self.stateTaxSavings.text = Config.addCommasToNumber(number: (user?.getStateTaxSavings())!)
    }
    
    private func enabledText(enable: Bool, labels: UILabel...){
        for label in labels {
            label.isEnabled = enable
        }
    }
}

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
    
    let shapeLayer = CAShapeLayer()

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
        setInitialValues()
        let views = Views()
        let path = views.drawLine()
        self.shapeLayer.path = path.cgPath
        self.shapeLayer.strokeColor = UIColor.lightGray.cgColor
        self.shapeLayer.lineWidth = 0.5
        
        self.view.layer.addSublayer(shapeLayer)
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
            self.fsaPreTaxDeduction.contributionAmount = currentValue
            self.fsaContributionAmount.text = Config.addCommasToNumber(number: currentValue)
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.spouseFsaPreTaxDeduction.contributionAmount = currentValue
            self.spouseFSAContribution.text = Config.addCommasToNumber(number: currentValue)
        }
        calculateTaxSavings()
    }

    @IBAction func contributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            self.fourOOneKPreTaxDeduction.contributionAmount = currentValue
            self.contribution401.text = Config.addCommasToNumber(number: currentValue)
        }else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.spouseFourOOneKPreTaxDeduction.contributionAmount = currentValue
            self.spouse401KContribution.text = Config.addCommasToNumber(number: currentValue)
        }
        calculateTaxSavings()
    }
    
    private func prepareContributionSlider() {
        if(self.segmentSelector.selectedSegmentIndex == 0){
            self.fourOOneKSlider.setValue(Float(self.fourOOneKPreTaxDeduction.contributionAmount), animated: true)
            self.fsaSlider.setValue(Float(self.fsaPreTaxDeduction.contributionAmount), animated: true)
            self.spouse401KContribution.isEnabled = false
            self.spouseFSAContribution.isEnabled = false
            self.contribution401.isEnabled = true
            self.fsaContributionAmount.isEnabled = true
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            self.fourOOneKSlider.setValue(Float(self.spouseFourOOneKPreTaxDeduction.contributionAmount), animated: true)
            self.fsaSlider.setValue(Float(self.spouseFsaPreTaxDeduction.contributionAmount), animated: true)
            self.spouse401KContribution.isEnabled = true
            self.spouseFSAContribution.isEnabled = true
            self.contribution401.isEnabled = false
            self.fsaContributionAmount.isEnabled = false
        }
    }
    
    private func setInitialValues(){
        self.fsaContributionAmount.text = Config.addCommasToNumber(number: 0)
        self.contribution401.text = Config.addCommasToNumber(number: 0)
        self.taxSavings.text =   Config.addCommasToNumber(number: 0)

    }
    
    private func calculateTaxSavings(){
        self.taxSavings.text =   Config.addCommasToNumber(number: (user?.getTaxSavings())!)
        self.fedTaxSavings.text = Config.addCommasToNumber(number: (user?.getFedTaxSavings())!)
        self.stateTaxSavings.text = Config.addCommasToNumber(number: (user?.getStateTaxSavings())!)
    }
}

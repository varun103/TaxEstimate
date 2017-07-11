//
//  ResultsViewController.swift
//  Tax-estimate
//
//  Created by Varun Ajmera on 11/30/16.
//  Copyright © 2016 Varun Ajmera. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ResultsViewController: UIViewController, GADBannerViewDelegate {
    
    private final let screenTitle:String = "Pre-Tax Contribution Savings"
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
    
    @IBOutlet weak var summaryButton: CustomButton!
    @IBOutlet weak var estimatedTaxSavings: UILabel!
    
    @IBOutlet weak var adsBannerView: GADBannerView!
    private var fourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    private var spouseFourOOneKPreTaxDeduction: FourOOneKPreTaxDeduction = FourOOneKPreTaxDeduction()
    
    private var fsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    private var spouseFsaPreTaxDeduction: FSAHealthPreTaxDeduction = FSAHealthPreTaxDeduction()
    
    let shapeLayer = CAShapeLayer()
    
    var user: User?
    
    
    override func viewDidLoad() {
        
        self.navigationItem.title = self.screenTitle
        self.segmentSelector.isHidden = true
        
        if(user?.status == FilingStatusEnum.married) {
            
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
        //self.summaryButton.gradient.removeFromSuperlayer()
        //self.summaryButton.layer.shadowOpacity = 0.0
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adsBannerView.adUnitID = "ca-app-pub-1253615041445374/5188157448"
        adsBannerView.rootViewController = self
        adsBannerView.load(request)

        
    }
    
    override func viewDidLayoutSubviews() {
        self.shapeLayer.frame = self.view.bounds
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        prepareContributionSlider()
    }
    
    @IBAction func fsaContributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        let prevValue = self.fsaPreTaxDeduction.contributionAmount
        let prevValueSpouse = self.spouseFsaPreTaxDeduction.contributionAmount
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            do {
                try self.fsaPreTaxDeduction.setContributionAmount(amount: currentValue)
                self.fsaContributionAmount.text = Config.addCommasToNumber(number: currentValue)
            } catch {
                self.showAlert()
                do {
                    try self.fsaPreTaxDeduction.setContributionAmount(amount: prevValue)
                    self.fsaContributionAmount.text = Config.addCommasToNumber(number: prevValue)
                } catch {}

            }
        } else if (self.segmentSelector.selectedSegmentIndex == 1) {
            do {
                try self.spouseFsaPreTaxDeduction.setContributionAmount(amount: currentValue)
                self.spouseFSAContribution.text = Config.addCommasToNumber(number: currentValue)
            } catch {
                self.showAlert()
                do {
                    try self.spouseFsaPreTaxDeduction.setContributionAmount(amount: prevValueSpouse)
                    self.spouseFSAContribution.text = Config.addCommasToNumber(number: prevValue)
                } catch {}
            }
        }
        calculateTaxSavings()
    }
    
    @IBAction func contributionSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        let prevValue = self.fourOOneKPreTaxDeduction.contributionAmount
        let prevValueSpouse = self.spouseFourOOneKPreTaxDeduction.contributionAmount
        if(self.segmentSelector.selectedSegmentIndex == 0) {
            do {
                try self.fourOOneKPreTaxDeduction.setContributionAmount(amount: currentValue)
                self.contribution401.text = Config.addCommasToNumber(number: currentValue)
            } catch {
                self.showAlert()
                do {
                     try self.fourOOneKPreTaxDeduction.setContributionAmount(amount: prevValue)
                     self.contribution401.text = Config.addCommasToNumber(number: prevValue)
                } catch {}
            }
        }else if (self.segmentSelector.selectedSegmentIndex == 1) {
            do {
                try self.spouseFourOOneKPreTaxDeduction.setContributionAmount(amount: currentValue)
                self.spouse401KContribution.text = Config.addCommasToNumber(number: currentValue)
            } catch {
                self.showAlert()
                do {
                      try self.spouseFourOOneKPreTaxDeduction.setContributionAmount(amount: prevValueSpouse)
                      self.spouse401KContribution.text = Config.addCommasToNumber(number: prevValue)
                } catch {}
            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "summary" {
            if let viewSummary = segue.destination as? TaxBracketViewController {
                viewSummary.user = self.user
            }
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    
    func showAlert() {
        // create the alert
        let alert = CustomAlert.create(message: "Deduction amount cannot exceed income")
        
        self.present(alert, animated: true, completion: nil)
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

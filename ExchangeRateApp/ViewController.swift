//
//  ViewController.swift
//  ExchangeRateApp
//
//  Created by Huy on 05/01/2023.
//

import UIKit
import Alamofire


class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    var exchangeRates: [String : Double] = [:]
    var inputMoneyRate: Double = 0
    var outputMoneyRate: Double = 0
    var isGetRate: Bool = false
    var rate: Double = 0
    var rates: [String] = []
    var isPickInputMoney : Bool?
    
    @IBOutlet weak var txtInputMoneyType: UITextField!
    
    @IBOutlet weak var txtOutputMoneyType: UITextField!
    
    @IBOutlet weak var lblExchangeRate: UILabel!
    
    @IBOutlet weak var lblWarning: UILabel!
    
    @IBOutlet weak var txtMoneyExchangeAmount: UITextField!
    
    @IBOutlet weak var lblExchangeMoneyOutput: UILabel!
    
    @IBOutlet weak var tblMoneyLabelName: UITableView!
    
    @IBOutlet weak var btnChartRate: UIButton!
    override func viewDidLoad() {
        getExchangeRateFromAPI()
        super.viewDidLoad()
        tblMoneyLabelName.dataSource = self
        tblMoneyLabelName.delegate = self
        tblMoneyLabelName.register(UINib(nibName: "moneyNamesTableViewCell", bundle: nil), forCellReuseIdentifier: "cellNameIdentifier")
      
    }
    
    func getExchangeRateFromAPI(){
        AF.request("https://v6.exchangerate-api.com/v6/5532463afde65f77df445420/latest/USD",method: .get).responseDecodable(of: ExchangeRate.self){ responseData in
            if let data = responseData.value{
                self.exchangeRates = data.conversionRates
                self.getRates()
            }
        }
    }
    
    @IBAction func btnGetExhangeRate(_ sender: UIButton) {
        if checkExchangeRateValid()
        {
            rate = outputMoneyRate/inputMoneyRate
            lblExchangeRate.text = "\(rate)"
            isGetRate = true
            btnChartRate.isHidden = false
        } else {
            lblExchangeRate.text = ""
            isGetRate = false
        }
       
    }
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMoneyLabelName.dequeueReusableCell(withIdentifier: "cellNameIdentifier", for: indexPath) as! moneyNamesTableViewCell
        
        cell.lblName.text = rates[indexPath.row]
        
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPickInputMoney == true {
            txtInputMoneyType.text = rates[indexPath.row]
        } else if (isPickInputMoney == false){
            txtOutputMoneyType.text = rates[indexPath.row]
        }
        txtMoneyExchangeAmount.text = ""
        lblExchangeMoneyOutput.text = ""
        tblMoneyLabelName.isHidden = true
    }
        
   
    
    func check() -> Bool {
        if (txtInputMoneyType.text != "" && txtOutputMoneyType.text != "")
        {
            inputMoneyRate = exchangeRates[txtInputMoneyType.text!] ?? 0
            outputMoneyRate = exchangeRates[txtOutputMoneyType.text!] ?? -1
            return true
        } else {
            lblWarning.text = "Chưa nhập đủ thông tin"
            return false
        }
    }
    func checkExchangeRateValid()-> Bool {
        let isCheck = check()
        if isCheck {
            if (inputMoneyRate == 0) {
                if outputMoneyRate != -1
                {
                    lblWarning.text = "Nhập sai loại tiền muốn chuyển đổi!"
                    return false
                } else if outputMoneyRate == -1 {
                    lblWarning.text = "Nhập sai tên các loại tiền !"
                    return false
                } else if (inputMoneyRate != 0 && outputMoneyRate == -1){
                    lblWarning.text = "Nhập sai loại tiền muốn chuyển đổi đến!"
                    return false
                }
            }
        }
        return true
    }
    
    
    @IBAction func txtInputMoneyChange(_ sender: UITextField) {
        let outputMoney =  (Double(txtMoneyExchangeAmount.text!) ?? 0) * rate
        if(isGetRate)
        {
            lblExchangeMoneyOutput.text = "\(outputMoney)"
            lblWarning.text = ""
        }else {
            lblWarning.text = "Chưa lấy tỉ lệ đổi hoán!"
        }
        
    }
    
    func getRates() {
        for (key,_) in exchangeRates {
            if rates.contains(key) == false{
                rates.append(key)
            }
        }
        tblMoneyLabelName.reloadData()
    }
    
    
    @IBAction func btnMoneyInputPicker(_ sender: UIButton) {
        isPickInputMoney = true
        tblMoneyLabelName.isHidden = false
    }
    
    
    @IBAction func btnMoneyOutputPicker(_ sender: UIButton) {
        isPickInputMoney = false
        tblMoneyLabelName.isHidden = false
    }
    
    @IBAction func btnChartRates(_ sender: UIButton) {
        let rateChartVC = storyboard?.instantiateViewController(withIdentifier: "ChartViewControllerIdentifier") as! ChartViewController
        rateChartVC.rate = inputMoneyRate
        rateChartVC.rates = exchangeRates
        navigationController?.pushViewController(rateChartVC, animated: true)
        
    }
}


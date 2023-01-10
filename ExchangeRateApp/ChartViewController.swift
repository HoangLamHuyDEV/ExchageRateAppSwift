//
//  ChartViewController.swift
//  ExchangeRateApp
//
//  Created by Huy on 09/01/2023.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    var commonUseExchangeRates: [BarChartDataEntry] = []
    var rates:[String:Double] = [:]
    
    var rate: Double?
    
    @IBOutlet weak var rateBarChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rateBarChartView.animate(yAxisDuration: 2.0)
        setupData()
    }
    
    func setupData() {
        let Pick = BarChartDataEntry(x: 1, y: 1)
        let USD = BarChartDataEntry(x: 2, y: rates["USD"]!/rate!)
        let EUR = BarChartDataEntry(x: 3, y: rates["EUR"]!/rate!)
        let JPY = BarChartDataEntry(x: 4, y: rates["JPY"]!/rate!)
        let CNY = BarChartDataEntry(x: 5, y: rates["CNY"]!/rate!)
        let AUD = BarChartDataEntry(x: 5, y: rates["AUD"]!/rate!)
        
        commonUseExchangeRates.append(Pick)
        commonUseExchangeRates.append(USD)
        commonUseExchangeRates.append(EUR)
        commonUseExchangeRates.append(JPY)
        commonUseExchangeRates.append(CNY)
        commonUseExchangeRates.append(AUD)
                                                   
        let chartDataSet = BarChartDataSet(entries: commonUseExchangeRates, label: "Tỉ lệ chuyển đổi đến một số loại tiền tệ thông dụng.")
            let chartData = BarChartData(dataSet: chartDataSet)
            rateBarChartView.data = chartData
        }
    
}

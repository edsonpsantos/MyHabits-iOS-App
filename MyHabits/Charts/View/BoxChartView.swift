//
//  BoxChartView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 08/01/2024.
//

import SwiftUI
import Charts


struct BoxChartView: UIViewRepresentable {
    
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.leftAxis.axisLineColor = .orange
        uiView.animate(yAxisDuration: 1.0)
        
        uiView.data = addData()
        
        return uiView
    }
    
    private func addData()-> LineChartData{
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradientColors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: gradientColors as CFArray,
            locations: colorLocations)
                
        let linearGradientFill = LinearGradientFill(gradient: gradient!, angle: 90.0)
        
        let dataSet = LineChartDataSet(entries: entries, label: "")
        
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.orange)
        dataSet.circleColors = [.red]
        dataSet.drawFilledEnabled = true
        dataSet.valueColors = [.red]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.fill = linearGradientFill
        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
}

#Preview {
    BoxChartView(entries: .constant([
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 5.0, y: 12.0),
        ChartDataEntry(x: 9.0, y: 6.0)
    ]), dates: .constant([
        "01/01/2024",
        "02/01/2024"
    ]))
    .frame(maxWidth: .infinity, maxHeight: 350)
}

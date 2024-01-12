//
//  ChartViewModel.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 08/01/2024.
//

import Foundation
import SwiftUI
import Charts

class ChartViewModel: ObservableObject{
    
    
    @Published var entries:[ChartDataEntry] = [
        ChartDataEntry(x:1.0, y: 2.0),
        ChartDataEntry(x:2.0, y: 6.0),
        ChartDataEntry(x:3.0, y: 28.0),
        ChartDataEntry(x:4.0, y: 12.0),
        ChartDataEntry(x:5.0, y: 32.0),
        ChartDataEntry(x:6.0, y: 42.0),
        ChartDataEntry(x:7.0, y: 15.0),
        ChartDataEntry(x:8.0, y: 6.0),
        ChartDataEntry(x:9.0, y: 9.0),
        ChartDataEntry(x:10.0, y: 11.0)
    ]
    
    @Published var dates = [
    "2024/01/01",
    "2024/02/01",
    "2024/03/01",
    "2024/04/01",
    "2024/05/01",
    "2024/06/01",
    "2024/07/01",
    "2024/08/01",
    "2024/09/01",
    "2024/10/01",
    ]
    
}

//
//  ChartView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 04/01/2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)

    }
}



#Preview {
    ChartView(viewModel: ChartViewModel())
}

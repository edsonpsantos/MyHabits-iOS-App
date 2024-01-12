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
        ZStack{
            if case ChartUiState.loading = viewModel.uiSate {
                ProgressView()
            } else {
                VStack {
                    if case ChartUiState.emptyChart = viewModel.uiSate {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 25, alignment: .center)
                        Text("No habits found :(")
                    } else if case ChartUiState.error(let message) = viewModel.uiSate {
                        Text("")
                            .alert(isPresented: .constant(true)){
                                Alert(title: Text("Ops!  \(message)"),
                                      message: Text("Try again ?"),
                                      primaryButton: .default(Text("Yes")){
                                    viewModel.onAppear()
                                }, secondaryButton: .cancel())
                            }
                    } else{
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                            .frame(maxWidth: .infinity, maxHeight: 350)
                    }
                }
            }
        }
    }
}


#Preview {
    HabitCardViewRouter.makeChartView(id: 1)
}

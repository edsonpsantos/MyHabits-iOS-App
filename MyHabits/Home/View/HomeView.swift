//
//  HomeView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/08/2023.
//

import SwiftUI

struct HomeView:View{
    
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    
    var body: some View{
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Habits")
            }.tag(0)
            
            viewModel.habitForChartView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Charts")
            }.tag(1)
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
            }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.orange)
    }
}


struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView(viewModel: HomeViewModel())
    }
}

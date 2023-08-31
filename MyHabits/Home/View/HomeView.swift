//
//  HomeView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 16/08/2023.
//

import SwiftUI

struct HomeView:View{
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View{
        Text("Olá Home View")
    }
}


struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView(viewModel: HomeViewModel())
    }
}

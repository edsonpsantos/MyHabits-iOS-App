//
//  HabitDetailView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 25/10/2023.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .center, spacing: 12.0){
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(.title.bold())
                
                Text("Unit: \(viewModel.label)\n")
            }
            VStack{
                TextField("Write the amount realized here", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.horizontal,32)
            
            Text("Updates must be carried out within 24 hours.")
            Text("Habits are built daily").padding(.horizontal)
            
            LoadingButtonView(
                action: {
                
            }, text: "Save",disabled: self.viewModel.value.isEmpty, showProgressBar: self.viewModel.uiState == .loading )
            .padding(.horizontal,16)
            .padding(.vertical,8)
         
            Button("Cancel"){
                //dismiss / pop exit
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Play Drums", label: "hours"))
                .previewDevice("iPhone 11")
                .preferredColorScheme(colorValue)
            
        }
    }
}

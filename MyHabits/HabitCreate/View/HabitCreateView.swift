//
//  HabitCreateView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/01/2024.
//

import SwiftUI

struct HabitCreateView: View {
    
    @ObservedObject var viewModel: HabitCreateViewModel
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var shouldPresentCamera = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .center, spacing: 12.0){
                Button(action: {
                    shouldPresentCamera = true
                }, label: {
                    VStack{
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.orange)
                        
                        Text("Click here to send !")
                            .foregroundColor(.orange)
                    }
                })
                .padding(.bottom,12)
            }
            VStack{
                TextField("Write the name of the habit here", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.horizontal,32)
            
            VStack{
                TextField("Enter the unit of measurement here", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.horizontal,32)
            
            
            LoadingButtonView(
                action: {
                    viewModel.save()
            }, text: "Save",
                disabled: viewModel.name.isEmpty || viewModel.label.isEmpty,
                showProgressBar: viewModel.uiState == .loading )
            .padding(.horizontal,16)
            .padding(.vertical,8)
         
            Button("Cancel"){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                    withAnimation(.easeOut(duration: 2)) {
                        self.presentationMode.wrappedValue.dismiss()                   }
                }
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
        
    }
}

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            HabitCreateView(viewModel: HabitCreateViewModel(interactor: HabitDetailInteractor()))
                .previewDevice("iPhone 11")
                .preferredColorScheme(colorValue)
            
        }
    } 
}

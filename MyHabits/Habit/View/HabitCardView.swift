//
//  HabitCardView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 21/10/2023.
//

import SwiftUI

struct HabitCardView: View {
    
    @State private var actionButton = false
    
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            NavigationLink(
                destination: viewModel.habitDetailView(),
                ///*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                isActive: self.$actionButton,
                label: {
                    EmptyView()
                })
            
            Button(action: {
                self.actionButton = true
            }, label: {
                HStack {
                    Image(systemName:"square.and.pencil")
                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top){
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4.0){
                            Text(viewModel.name)
                                .foregroundColor(.orange)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                        }
                        .frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4.0){
                            Text("Registered")
                                .foregroundColor(.orange)
                                .bold()
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
        }
        .background(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.orange, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x:2.0, y: 2.0)
        )
        .padding(.horizontal,4)
        .padding(.vertical,8)
    }
}

struct HabitCardView_Previews: PreviewProvider{
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            NavigationView {
                List{
                    HabitCardView(viewModel:
                                    HabitCardViewModel(id: 1,
                                                       icon: "https://placehold.co/150x150",
                                                       date: "01/01/2023",
                                                       name: "Play Drum",
                                                       label: "Hours",
                                                       value: "2",
                                                       state: .green))
                    
                    HabitCardView(viewModel:
                                    HabitCardViewModel(id: 2,
                                                       icon: "https://placehold.co/150x150",
                                                       date: "01/01/2023",
                                                       name: "Play Drum",
                                                       label: "Hours",
                                                       value: "2",
                                                       state: .red))
                    
                    
                }
                .frame(maxWidth: .infinity)
                .navigationTitle("Teste")
            }
            .previewDevice("iPhone 15Pro")
            .preferredColorScheme($0)
        }
    }
}

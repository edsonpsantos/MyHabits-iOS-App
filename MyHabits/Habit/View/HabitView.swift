//
//  HabitView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 27/09/2023.
//

import Foundation
import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel = HabitViewModel(interactor: HabitInteractor())
    
    var body: some View{
        ZStack {
            if case HabitUIState.loading=viewModel.uiState{
                progress
            } else{
                
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12){
                            topContainer
                            
                            addButton
                            
                            if case HabitUIState.emptyList = viewModel.uiState{
                                Spacer(minLength: 60)
                                VStack{
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    Text("No habits found :(")
                                }
                            }
                            else if case HabitUIState.fullList(let rows) = viewModel.uiState{
                                // Multi views elements (LIST ITEMS) optmization
                                LazyVStack{
                                    ForEach(rows, content: HabitCardView.init(viewModel:))
                                }.padding(.horizontal,14)
                            }
                            else if case HabitUIState.error(let message) = viewModel.uiState { Text(message)
                                    .alert(isPresented: .constant(true)) {
                                        Alert(title: Text("Ups! \(message)"),
                                              message: Text("Try again ?"),
                                              primaryButton: .default(Text("Yes")) { viewModel.onAppear()
                                        },
                                              secondaryButton: .cancel())
                                    }
                            }
                        }
                    }
                    .navigationBarTitle(Text("My Habits"))
                }
            }
        }.onAppear{
            if !viewModel.opened {
                viewModel.onAppear()
            }
        }
    }
}


extension HabitView{
    var progress: some View{
        ProgressView()
    }
}
extension HabitView {
    var addButton: some View{
        NavigationLink {
            Text("Add Habit Screen").frame(maxWidth: .infinity, maxHeight: .infinity)
        } label: {
            Label("Create Habit", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(.horizontal, 16)
    }
}

extension HabitView{
    var topContainer: some View{
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(.title).bold()
                .foregroundColor(Color.orange)
            
            Text(viewModel.headline)
                .font(.title3).bold()
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.description)
                .font(.subheadline)
                .foregroundColor(Color("textColor"))
        }
        .frame(maxWidth:   .infinity)
        .padding(.vertical,32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth:1))
        .padding(.horizontal,16)
        .padding(.top, 16)
    }
}


struct HabitView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self) { HomeViewRouter.makeHabitView(viewModel: HabitViewModel(interactor: HabitInteractor()))
                .previewDevice("iPhone 15Pro")
                .preferredColorScheme($0)
        }
    }
}

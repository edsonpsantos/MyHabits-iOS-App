//
//  SplashView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 14/08/2023.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel

    var body: some View{
        Group{
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                Text("Carregar Home Screen")
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

//Funçoes em extensoes
// So ficara visivel dentro da classe criada
//Pode receber parametros para dinamizar a criação do Objeto|Componente
extension SplashView{
    func loadingView(error: String? = nil) -> some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error=error{
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("My Habits"), message: Text(error), dismissButton: .default(Text("Ok")){
                          //Ação do botão para depois que sumir o alert
                        })
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            VStack{
                let viewModel = SplashViewModel(interactor: SplashInteractor())
                SplashView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme(colorValue)
            
        }
    }
}

/*
// Compartilhar | Objeto
// Quando precisa reutilizar o componente em outra parte do codigo
struct LoadingView: View{
    var body: some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(.white)
                .ignoresSafeArea()
        }
    }
}

// Criar uma variável em extensão
// Só ficará visível dentro da classe criada
extension SplashView{
    var loading:some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(. )
                .ignoresSafeArea()
        }
    }
    
}
 */





//
//  SignInView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 15/08/2023.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View{
        ZStack{
            if case SigInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            }else{
                NavigationView {
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .center, spacing: 20){
                            Spacer(minLength: 100)
                            VStack(alignment: .center, spacing: 8){
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal,48)
                                
                                Text("Login")
                                    .font(.system(.title).bold())
                                    .foregroundColor(.orange)
                                    .padding(.bottom,8)
                                
                                emailField
                                passwordField
                                enterButton
                                registerLink
                                
                                Text("Copyright @Mentor Soluções 2023")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                        }
                        if case SigInUIState.error(let value)=viewModel.uiState{
                            Text("")
                                .alert(isPresented: .constant(true)){
                                    Alert(title: Text("My Habits"), message: Text(value), dismissButton: .default(Text("Ok")){
                                      //Ação do botão para depois que sumir o alert
                                    })
                                }
                        }
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal,32)
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarHidden(navigationHidden)
                }

            }
        }
    }
}

extension SignInView{
    var emailField: some View{
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "Invalid E-mail",
                     failure: !viewModel.email.isEmail())
        .autocapitalization(.none)
    }
}

extension SignInView{
    var passwordField: some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Password",
                     keyboard: .numberPad,
                     error: "The password must have at least 8 characters",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignInView{
    var enterButton: some View{
        LoadingButtonView(action: {viewModel.login()},
                          text: "Log In",
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8,
                          showProgressBar: self.viewModel.uiState == SigInUIState.loading)
    }
}

extension SignInView{
    var registerLink: some View{
        VStack{
            Text("Don't have an active login?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack{
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: 1,
                    selection: $action,
                    label: {EmptyView()})
                Button("Register here"){
                    self.action = 1
                }
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        ForEach(ColorScheme.allCases, id: \.self) { colorValue in
            VStack{
                SignInView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme(colorValue)
            
        }

    }
}


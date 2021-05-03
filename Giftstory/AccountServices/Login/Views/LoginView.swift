//
//  ContentView.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var isPasswordVisible = false
    @State var isLoading = false
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ScrollView {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            LottieView(name: "4432-face-scanning", loopMode: .loop)
                                .frame(width: 200, height: 200)

                            Text("Log in to your account")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(color)
                                .padding()
                            
                            TextField("E-mail", text: $email)
                                .padding()
                                .autocapitalization(.none)
                                .background(RoundedRectangle(cornerRadius: 4).stroke(emailFieldColor, lineWidth: 2))
                                .padding(.top, 25)
                            
                            HStack(spacing: 15) {
                                VStack {
                                    if isPasswordVisible {
                                        TextField("Password", text: $password)
                                            .autocapitalization(.none)
                                    } else {
                                        SecureField("Password", text: $password)
                                            .autocapitalization(.none)
                                    }
                                }
                                
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(color)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(passwordFieldColor, lineWidth: 2))
                            .padding(.top, 25)
                            
                            HStack {
                                Spacer()
                                NavigationLink(destination: ForgotPasswordView(viewModel: .init())) {
                                    Text("Forgot password?")
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.top, 20)
                            
                            HStack {
                                Spacer()
                                NavigationLink(destination: RegistrationView(viewModel: .init())) {
                                    Text("Not registered? Sign up now")
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.top, 20)
                            
                            Button(action: {
                                validateFields()
                            }) {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                                    .background(isButtonEnabled ? Color.red : Color.red.opacity(0.5))
                                    .cornerRadius(10)
                                    .padding(.top, 30)
                            }
                            .disabled(!isButtonEnabled)
                        }
                        .padding(.horizontal, 30)
                    }
                    .alert(isPresented: $alert) {
                        Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
    
    var isButtonEnabled: Bool {
        email.isValidEmail && !email.isEmpty && password.count >= 8
    }
    
    var emailFieldColor: Color {
        if email.isEmpty {
            return color
        } else if !email.isValidEmail {
            return .red
        } else {
            return Color.green.opacity(0.6)
        }
    }
    
    var passwordFieldColor: Color {
        if password.isEmpty {
            return color
        } else if password.count < 8 {
            return .red
        } else {
            return Color.green.opacity(0.6)
        }
    }
    
    func validateFields() {
        isLoading = true
        viewModel.authenticate(email: email.lowercased(), password: password) { state in
            isLoading = false
            switch state {
            case .failure(let apiError):
                if case .errorMessage(let errorMessage) = apiError {
                    error = errorMessage
                } else {
                    error = "Sorry, something went wrong. Please try again later."
                }
                alert.toggle()
            case .success(let response):
                print(response.message ?? "")
            default: break
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}

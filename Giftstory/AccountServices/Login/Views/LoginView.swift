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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Log in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .padding()
                
                TextField("E-mail", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(email != "" ? .red : color, lineWidth: 2))
                    .padding(.top, 25)
                
                HStack(spacing: 15) {
                    VStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
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
                .background(RoundedRectangle(cornerRadius: 4).stroke(password != "" ? .red : color, lineWidth: 2))
                .padding(.top, 25)
                                
                HStack {
                    Spacer()
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot password?")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: RegistrationView()) {
                        Text("Not registered? Sign up now")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
                
                Button(action: {
                    viewModel.authenticate(email: email, password: password)
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.top, 30)
                }
            }
            .padding(.horizontal, 30)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}

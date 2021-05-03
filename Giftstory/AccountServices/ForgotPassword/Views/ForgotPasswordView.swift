//
//  ForgotPasswordView.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var isLoading = false
    @State var alert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    VStack {
                        Text("Reset your password")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(color)
                            .padding()
                        
                        TextField("E-mail", text: $email)
                            .padding()
                            .autocapitalization(.none)
                            .background(RoundedRectangle(cornerRadius: 4).stroke(emailFieldColor, lineWidth: 2))
                            .padding(.top, 25)
                        
                        Button(action: {
                            sendResetPasswordLink()
                        }) {
                            Text("Confirm")
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
                    .alert(isPresented: $alert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
    
    var isButtonEnabled: Bool {
        email.isValidEmail && !email.isEmpty
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
    
    func sendResetPasswordLink() {
        isLoading = true
        viewModel.forgotPassword(email: email.lowercased()) { state in
            isLoading = false
            switch state {
            case .failure(let apiError):
                alertTitle = "Error"
                if case .errorMessage(let errorMessage) = apiError {
                    alertMessage = errorMessage
                } else {
                    alertMessage = "Sorry, something went wrong. Please try again later."
                }
                alert.toggle()
            case .success(let response):
                alertTitle = "Success!"
                alertMessage = response.message ?? "Check your e-mail for the reset password link!"
                alert.toggle()
            default: break
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(viewModel: .init())
    }
}

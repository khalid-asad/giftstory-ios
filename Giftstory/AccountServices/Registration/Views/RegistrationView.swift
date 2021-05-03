//
//  RegistrationView.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel

    @State var color = Color.black.opacity(0.7)
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var dateOfBirth = Date()
    @State var password = ""
    @State var confirmPassword = ""
    @State var isDatePickerVisible = false
    @State var isPasswordVisible = false
    @State var isConfirmPasswordVisible = false
    @State var isLoading = false
    @State var alert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    var body: some View {
        VStack {
            Text("Register with Giftstory")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
                .padding()
            
            TextField("First Name", text: $firstName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(firstNameFieldColor, lineWidth: 2))
                .padding(.top, 25)
            
            TextField("Last Name", text: $lastName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(lastNameFieldColor, lineWidth: 2))
                .padding(.top, 25)
            
            TextField("E-mail", text: $email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(emailFieldColor, lineWidth: 2))
                .padding(.top, 25)
            
            let bind = Binding<String>(
                get: { self.dateOfBirth.toStringSlashedDMY() },
                set: { self.dateOfBirth = $0.toDate ?? Date() }
            )
            
            TextField("Date of Birth", text: bind)
                .padding()
                .onTapGesture {
                    isDatePickerVisible.toggle()
                }
                .background(RoundedRectangle(cornerRadius: 4).stroke(color, lineWidth: 2))
                .padding(.top, 25)
            
            
//            HStack {
//                Text("Date of Birth")
//                Spacer()
//                Text("\(dateFormatter.string(from: dateOfBirth))")
//                    .onTapGesture {
//                        self.isDatePickerVisible.toggle()
//                    }
//                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
//                    .background(isDatePickerVisible
//                                    ? Color.clear
//                                    : Color.gray)
//            }
            if isDatePickerVisible {
                DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
            }

            
            
            
            
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
            .background(RoundedRectangle(cornerRadius: 4).stroke(passwordFieldColor, lineWidth: 2))
            .padding(.top, 25)
            
            HStack(spacing: 15) {
                VStack {
                    if isConfirmPasswordVisible {
                        TextField("Confirm Password", text: $confirmPassword)
                    } else {
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                }
                Button(action: {
                    isConfirmPasswordVisible.toggle()
                }) {
                    Image(systemName: isConfirmPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(color)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(confirmPasswordFieldColor, lineWidth: 2))
            .padding(.top, 25)
                        
            Button(action: {
                submitRegistrationInfo()
            }) {
                Text("Register")
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
    
    var isButtonEnabled: Bool {
        firstName.count >= 2 && lastName.count >= 2 && email.isValidEmail && !email.isEmpty && password.count >= 8 && confirmPassword.count >= 8
    }
    
    var firstNameFieldColor: Color {
        if firstName.isEmpty {
            return color
        } else if firstName.count < 2 {
            return .red
        } else {
            return Color.green.opacity(0.6)
        }
    }
    
    var lastNameFieldColor: Color {
        if lastName.isEmpty {
            return color
        } else if lastName.count < 2 {
            return .red
        } else {
            return Color.green.opacity(0.6)
        }
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
    
    var confirmPasswordFieldColor: Color {
        if confirmPassword.isEmpty {
            return color
        } else if confirmPassword.count < 8 || confirmPassword != password {
            return .red
        } else {
            return Color.green.opacity(0.6)
        }
    }
    
    func submitRegistrationInfo() {
        isLoading = true
        viewModel.registerAccount(firstName: firstName, lastName: lastName, email: email.lowercased(), password: password, birthday: dateOfBirth) { state in
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
                alertMessage = response.message ?? "Check your e-mail for the registration link!"
                alert.toggle()
            default: break
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: .init())
    }
}

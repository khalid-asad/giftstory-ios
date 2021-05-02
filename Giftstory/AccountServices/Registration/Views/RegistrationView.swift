//
//  RegistrationView.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import SwiftUI

extension Date {
    
    /// Converts a Date of format yyyy-MM-dd into a String of day/month/year format.
    func toStringSlashedDMY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    /// Converts a string to Date format of yyyy-MM-dd.
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)
    }
}

struct RegistrationView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var dateOfBirth = Date()
    @State var password = ""
    @State var confirmPassword = ""
    @State var isDatePickerVisible = false
    @State var isPasswordVisible = false
    @State var isConfirmPasswordVisible = false
    
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
            
            TextField("E-mail", text: $email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(email != "" ? .red : color, lineWidth: 2))
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
            .background(RoundedRectangle(cornerRadius: 4).stroke(password != "" ? .red : color, lineWidth: 2))
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
            .background(RoundedRectangle(cornerRadius: 4).stroke(confirmPassword != "" ? .red : color, lineWidth: 2))
            .padding(.top, 25)
                        
            Button(action: {
                
            }) {
                Text("Register")
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

//
//  ForgotPasswordView.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Reset your password")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .padding()
                
                TextField("E-mail", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(email != "" ? .red : color, lineWidth: 2))
                    .padding(.top, 25)
                                
                Button(action: {
                    
                }) {
                    Text("Confirm")
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

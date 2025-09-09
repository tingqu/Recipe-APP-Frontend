//
//  ViewableSecureField.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

struct ViewableSecureField: View {
    let caption: String
    @Binding var text: String
    let placeholder: String
    
//    @State private var password: String = ""
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(caption)
                        .font(.headline)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .frame(width: 310)
                
                if isSecure == true {
                    SecureField(placeholder, text: $text)
                        .safeAreaInset(edge: .leading) {
                            Image(systemName: "eye")
                                .onTapGesture {isSecure.toggle()}
                                .foregroundColor(.accent)
                        }
                        .padding()
                        .frame(width: 310, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(12)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }else{
                    TextField("Password", text: $text)
                        .safeAreaInset(edge: .leading) {
                            Image(systemName: "eye.slash")
                                .onTapGesture {isSecure.toggle()}
                                .foregroundColor(.accent)
                        }
                        .padding()
                        .frame(width: 310, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(12)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)

                }
            }
            .frame(width: geometry.size.width)
        } // End of GeometryReader
        .frame(height: 100)
    }
}

struct ViewableSecureField_Previews: PreviewProvider {
    static var previews: some View {
        ViewableSecureField(caption: "Password", text: .constant(""), placeholder: "Enter password")
    }
}

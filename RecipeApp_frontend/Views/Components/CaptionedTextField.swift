//
//  ViewableSecureField.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

struct CaptionedTextField: View {
    let caption: String
    @Binding var text: String
    let placeholder: String
    let imageName:String
    
//    @State private var password: String = ""
        
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
                TextField(placeholder, text: $text)
                    .safeAreaInset(edge: .leading) { Image(systemName: imageName)
                            .foregroundColor(.accent)
                    }
                    .padding()
                    .frame(width: 310, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(12)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .frame(width: geometry.size.width)
        } // End of GeometryReader
        .frame(height: 100)
    }
}

struct CaptionedTextField_Preview: PreviewProvider {
    static var previews: some View {
        CaptionedTextField(caption: "Password", text: .constant(""), placeholder: "Enter password", imageName: "lock")
    }
}

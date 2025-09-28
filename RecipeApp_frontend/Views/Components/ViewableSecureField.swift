////
////  ViewableSecureField.swift
////  AuthApp
////
////  Created by Neal Archival on 7/12/22.
////
//
//import SwiftUI
//
//struct ViewableSecureField: View {
//    let caption: String
//    @Binding var text: String
//    let placeholder: String
//    
//    @State private var isSecure: Bool = true
//    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack {
//                HStack {
//                    Text(caption)
//                        .font(.headline)
//                        .foregroundColor(Color.black)
//                    Spacer()
//                }
//                .frame(width: 310)
//                
//                if isSecure == true {
//                    SecureField(placeholder, text: $text)
//                        .safeAreaInset(edge: .leading) {
//                            Image(systemName: "eye")
//                                .onTapGesture {isSecure.toggle()}
//                                .foregroundColor(.accent)
//                        }
//                        .padding()
//                        .frame(width: 310, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(12)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//                }else{
//                    TextField("Password", text: $text)
//                        .safeAreaInset(edge: .leading) {
//                            Image(systemName: "eye.slash")
//                                .onTapGesture {isSecure.toggle()}
//                                .foregroundColor(.accent)
//                        }
//                        .padding()
//                        .frame(width: 310, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(12)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//
//                }
//            }
//            .frame(width: geometry.size.width)
//        } // End of GeometryReader
//        .frame(height: 100)
//    }
//}
//
//struct ViewableSecureField_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewableSecureField(caption: "Password", text: .constant(""), placeholder: "Enter password")
//    }
//}

import SwiftUI


struct ViewableSecureField: View {
    let caption: String
    @Binding var text: String
    let placeholder: String

    @State private var isSecure = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(caption)
                .font(.headline)
                .foregroundColor(.primary)

            ZStack {
                HStack(spacing: 12) {
                    Image(systemName: "lock")
                        .foregroundColor(.yellow)
                        .frame(width: 20, height: 20)

                    // 用条件渲染在同一层级切换
                    if isSecure {
                        SecureField(placeholder, text: $text)
                            .textContentType(.newPassword)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField(placeholder, text: $text)
                            .textContentType(.newPassword)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }

                    Spacer()

                    // 右侧“眼睛”按钮
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye" : "eye.slash")
                            .foregroundColor(.yellow)
                            .frame(width: 24, height: 24)
                    }
                    .contentShape(Rectangle())
                }
                .padding(.horizontal, 14)
                .frame(height: 50)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.05))
            )
        }
    }
}


#Preview("ViewableSecureField - Password") {
    ViewableSecureField(
        caption: "Password",
        text: .constant(""),
        placeholder: "Enter password"
    )
    .padding()
}

//
//  ViewableSecureField.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

//import SwiftUI
//
//struct CaptionedTextField: View {
//    let caption: String
//    @Binding var text: String
//    let placeholder: String
//    let imageName:String
//    
////    @State private var password: String = ""
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
//                TextField(placeholder, text: $text)
//                    .safeAreaInset(edge: .leading) { Image(systemName: imageName)
//                            .foregroundColor(.accent)
//                    }
//                    .padding()
//                    .frame(width: 310, height: 50)
//                    .background(Color.black.opacity(0.05))
//                    .cornerRadius(12)
//                    .disableAutocorrection(true)
//                    .autocapitalization(.none)
//            }
//            .frame(width: geometry.size.width)
//        } // End of GeometryReader
//        .frame(height: 100)
//    }
//}

import SwiftUI

struct CaptionedTextField: View {
    let caption: String
    @Binding var text: String
    let placeholder: String
    let systemImage: String
    var contentType: UITextContentType? = nil
    var keyboard: UIKeyboardType = .default
    var submitLabel: SubmitLabel = .done

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(caption)
                .font(.headline)
                .foregroundColor(.primary)

            HStack(spacing: 12) {
                Image(systemName: systemImage)
                    .foregroundColor(.yellow) // 你原来的 accent 色
                    .frame(width: 20, height: 20)

                TextField(placeholder, text: $text)
                    .textContentType(contentType)
                    .keyboardType(keyboard)
                    .submitLabel(submitLabel)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.05))
            )
        }
    }
}


#Preview("CaptionedTextField - Username") {
    CaptionedTextField(
        caption: "Username",
        text: .constant(""),
        placeholder: "Enter username",
        systemImage: "person",
        contentType: .username
    )
    .padding()
}

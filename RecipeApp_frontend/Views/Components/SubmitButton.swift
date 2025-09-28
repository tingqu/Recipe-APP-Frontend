import SwiftUI

struct SubmitButton: View {
    let text: String
    let submitAction: () async -> Void

    var body: some View {
        Button {
            Task { await submitAction() }
        } label: {
            Text(text)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.accent)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.black)
                .cornerRadius(12)
        }
        .padding(.horizontal, 20)                   
    }
}


struct TransparentButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1)
                )
        }
        .padding(.horizontal, 20)
    }
}


struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        TransparentButton(text: "Already have an account? Log in") {
                   print("Go to login screen")
               }
    }
}

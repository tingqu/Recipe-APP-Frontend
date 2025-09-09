import SwiftUI

struct SubmitButton: View {
    let text: String
    let submitAction: () async -> Void
    var body: some View {
        Button(action: {
            Task {
                await submitAction()
            }
        }) {
            Text(text)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.accent)
                .frame(width: 310, height: 60)
                .background(Color.black)
                .cornerRadius(12)
        }
    }
}

struct TransparentButtons:View{
    var body:some View{
        GeometryReader{ geometry in
            VStack {
                Button("Sign up ") { /* action */ }
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.07)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.25), lineWidth: 1)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        TransparentButtons()
    }
}

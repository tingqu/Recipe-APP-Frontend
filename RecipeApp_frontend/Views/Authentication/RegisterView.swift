import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack{
            LogoBanner()
            CaptionedTextField(caption: "Username", text: $username, placeholder: "Enter usernanme", imageName: "lock")
            CaptionedTextField(caption: "Email",text: $email, placeholder: "Enter email", imageName: "envelope")
            CaptionedTextField(caption: "Password", text: $password, placeholder: "Enter password", imageName: "lock")
            SubmitButton(text: "Sign Up") {
                print("Enrer")
            }
        }
    }
}

#Preview {
    RegisterView()
}

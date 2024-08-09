//import SwiftUI
//
//struct LoginView: View {
//    @StateObject private var viewModel = AuthenticationViewModel()
//
//    var body: some View {
//        VStack {
//            TextField("Email", text: $viewModel.email)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            SecureField("Password", text: $viewModel.password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button("Sign In") {
//                viewModel.signInWithEmail()
//            }
//            .padding()
//            Button("Forgot Password?") {
//                // Show password reset modal
//            }
//            .padding()
//            Button("Sign In with Google") {
//                viewModel.signInWithGoogle()
//            }
//            .padding()
//        }
//        .alert(item: $viewModel.errorMessage) { errorMessage in
//            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
//        }
//        .progressView($viewModel.isLoading)
//    }
//}

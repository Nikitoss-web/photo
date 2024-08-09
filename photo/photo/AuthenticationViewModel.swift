//import SwiftUI
////import Firebase
//import Combine
//
//class AuthenticationViewModel: ObservableObject {
//    @Published var email: String = ""
//    @Published var password: String = ""
//    @Published var isAuthenticated: Bool = false
//    @Published var errorMessage: String?
//
//    private var cancellables = Set<AnyCancellable>()
//
//    func signInWithEmail() {
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//            if let error = error {
//                self?.errorMessage = error.localizedDescription
//            } else {
//                self?.isAuthenticated = true
//            }
//        }
//    }
//
//    func signUpWithEmail() {
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
//            if let error = error {
//                self?.errorMessage = error.localizedDescription
//            } else {
//                self?.sendEmailVerification()
//            }
//        }
//    }
//
//    func sendEmailVerification() {
//        Auth.auth().currentUser?.sendEmailVerification { [weak self] error in
//            if let error = error {
//                self?.errorMessage = error.localizedDescription
//            }
//        }
//    }
//
//    func signInWithGoogle() {
//        // Google SignIn implementation
//    }
//
//    func resetPassword() {
//        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
//            if let error = error {
//                self?.errorMessage = error.localizedDescription
//            }
//        }
//    }
//}

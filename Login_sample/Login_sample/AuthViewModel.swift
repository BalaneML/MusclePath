//
//  AuthViewModel.swift
//  Login_sample
//
//  Created by a2lab on 2026/02/14.
//
import Foundation
import FirebaseAuth
import Combine
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false // ログイン状態管理
    @Published var isLoading = false

    // ログイン処理
    func login() {
        isLoading = true
        errorMessage = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            // 成功時
            print("ログイン成功: \(result?.user.uid ?? "")")
            self.isLoggedIn = true
        }
    }

    // 新規登録処理（必要な場合）
    func signUp() {
        isLoading = true
        errorMessage = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            // 成功時
            print("登録成功: \(result?.user.uid ?? "")")
            self.isLoggedIn = true
        }
    }
    
    // ログアウト処理
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            email = ""
            password = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

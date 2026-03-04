//
//  Untitled.swift
//  Login_sample
//
//  Created by a2lab on 2026/02/14.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        // ログイン状態によって画面を切り替え
        if viewModel.isLoggedIn {
            HomeView(viewModel: viewModel)
        } else {
            loginScreen
        }
    }
    
    // ログイン画面のUI定義
    var loginScreen: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea() // 背景色
            
            VStack(spacing: 20) {
                Text("ようこそ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                // メールアドレス入力
                TextField("メールアドレス", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                // パスワード入力
                SecureField("パスワード", text: $viewModel.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                // エラーメッセージ表示
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // ログインボタン
                Button(action: {
                    viewModel.login()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("ログイン")
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                
                // 新規登録ボタン（オプション）
                Button("アカウントをお持ちでない方はこちら") {
                    viewModel.signUp()
                }
                .foregroundColor(.blue)
                .font(.footnote)
                
                Button(action:{
                    viewModel.isLoggedIn=true
                }){
                    Text("ダミーで入る。")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray) //テスト用なのでグレーにしています
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

// ログイン後の遷移先（ここに友達のMapViewを組み込む）
struct HomeView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // 画面上部に小さくログアウトボタンを配置しておく
            HStack {
                Spacer()
                Button("ログアウト") {
                    viewModel.signOut()
                }
                .font(.footnote)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.trailing, 16)
                .padding(.top, 8)
            }
            .background(Color(.systemBackground))
            .zIndex(1) // マップの上にボタンが来るようにする
            
            // ここで友達の作ったマップ画面を呼び出す！
            MapView()
        }
    }
}

#Preview {
    LoginView()
}

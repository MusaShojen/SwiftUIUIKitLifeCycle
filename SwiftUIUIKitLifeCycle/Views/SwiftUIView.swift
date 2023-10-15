//
//  SwiftUIView.swift
//  SwiftUIUIKitLifeCycle
//
//  Created by Муса Шогенов on 14.10.2023.
//

import SwiftUI

struct User {
    let username: String
    let password: String
}

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false

    var body: some View {
      
            VStack {
                if isLoggedIn {
                   
                CameraListView()
                  

                } else {
                    Text("Authentication")
                    TextField("Login", text: $username)
                    SecureField("Password", text: $password)
                    Button("Login") {
                        if let user = authenticate(username: username, password: password) {
                            isLoggedIn = true
                            username = user.username
                            password = ""
                        } else {
                            
                        }
                    }
                }
            
        }.padding()
            .onAppear {
            print("LoginView appeared")
                }
            .onDisappear {
                          
            print("LoginView disappeared")
                }
    }

    func authenticate(username: String, password: String) -> User? {
        let users = [
            User(username: "root", password: "root"),
            User(username: "user2", password: "password2"),
        ]

        return users.first { $0.username == username && $0.password == password }
    }
}




#Preview {
    LoginView()
}

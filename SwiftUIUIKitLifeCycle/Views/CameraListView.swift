//
//  CameraListView.swift
//  SwiftUIUIKitLifeCycle
//
//  Created by Муса Шогенов on 15.10.2023.
//

//
//  CameraListView.swift
//  SwiftUIUIKitLifeCycle
//
//  Created by Муса Шогенов on 15.10.2023.
//

import SwiftUI

struct CameraListView: View {
    var cameraList = ["Camera On Stairs"] // Правильный текст для элемента в списке
    var body: some View {
        NavigationView {
            List(cameraList, id: \.self) { cameraName in
                NavigationLink(destination: MyViewControllerRepresentable()) {
                    Text(cameraName)
                }
            }
            .navigationTitle("Camera List")
            .padding()
            .onAppear {
            print("CameraListView appeared")
                }
            .onDisappear {
                          
            print("CameraListView disappeared")
                }
        }
    }
    
}


#Preview {
    CameraListView()
}

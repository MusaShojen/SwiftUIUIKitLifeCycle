//
//  UIViewControllerRepresentable.swift
//  SwiftUIUIKitLifeCycle
//
//  Created by Муса Шогенов on 15.10.2023.
//

import SwiftUI

struct MyViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> StreamViewController {
        let viewController = StreamViewController()
       
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: StreamViewController, context: Context) {
       
    }
}

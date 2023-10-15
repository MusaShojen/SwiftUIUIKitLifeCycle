//
//  StreamViewController.swift
//  SwiftUIUIKitLifeCycle
//
//  Created by Муса Шогенов on 15.10.2023.
//

import Foundation
import UIKit
import SnapKit




class StreamViewController: UIViewController {
    
    
    let toggleSwitch = UISwitch()
    var imageView = UIImageView()
    let mjpegReader = MjpegReader()
    
    let url = URL(string: "http://root:root@try.axxonsoft.com:8000/asip-api/live/media/DEMOSERVER/DeviceIpint.1/SourceEndpoint.video:0:0")!
    
    
    
    override func viewDidLoad() {
        print("StreamView DidLoad")
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        initialize()
        toggleSwitch.addTarget(self, action: #selector(switchStateChanged), for: .valueChanged)
        imageView.backgroundColor = .red
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("StreamView WillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("StreamView DidAppear")
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("StreamView WillDisappear")
        mjpegReader.stopStream()
        self.imageView.image = nil
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("StreamView DidDisappear")
    }
    
    
    @objc func switchStateChanged () {
        
        if toggleSwitch.isOn {
            print("Streaming")
            mjpegReader.readStream(url) { image, error in
             
                if let error = error {
                    print(error.localizedDescription)
                }
                if let image = image {
                    let uiImage = UIImage(cgImage: image)
                    DispatchQueue.main.async {
                    self.imageView.image = uiImage
                                    }
                   
                }
                
                
            }
            } else {
                mjpegReader.stopStream()
                self.imageView.image = nil
                print("not Streaming")
            }
        
    }
    
    
 
    func initialize() {
        
        self.view.addSubview(toggleSwitch)
        self.view.addSubview(imageView)
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-400)
            make.centerX.equalToSuperview()
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

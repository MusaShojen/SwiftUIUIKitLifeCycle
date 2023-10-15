//
//  MjpegReader.swift
//  SwiftUIUIKitLifeCycle
//
//  Created by Муса Шогенов on 15.10.2023.
//

import Foundation
import CoreGraphics

enum MjpegReadError: Error {
    case badResponse, parseImage

    var localizedDescription: String {
        switch self {
        case .badResponse:
            return "Bad Response"
        case .parseImage:
            return "Failed to parse image"
        }
    }
}


class MjpegReader: NSObject, URLSessionDelegate, URLSessionDataDelegate, ObservableObject{
    
    let startMarker = Data([0xFF, 0xD8])
    let endMarker = Data([0xFF, 0xD9])
    var buffer = Data()
    
    let configuration = URLSessionConfiguration.ephemeral
    
    var session : URLSession?
    var task : URLSessionDataTask?
    
    var handler: ((CGImage?, MjpegReadError?)->())?
    
    func readStream(_ url: URL, handler: @escaping (CGImage?, MjpegReadError?)->() ) {
        
        self.handler = handler
        session = URLSession.init(configuration: self.configuration, delegate: self, delegateQueue: nil)
        task = session?.dataTask(with: url)
        task?.resume()
        
    }
    
    func stopStream() {
        task?.cancel()
        task = nil
    }
    
    
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        guard let response = dataTask.response as? HTTPURLResponse, response.statusCode == 200 else {
            handler?(nil, .badResponse)
            return
        }
        
        if data.range(of: startMarker) != nil {
            print("started new frame")
            buffer = Data()

        }
        buffer.append(data)
        
        if data.range(of: endMarker) != nil {
            
            print("frame ended")
            let frame = parseFrame(buffer)
            handler?(frame, nil)
            
        }
        
        
    }
    
    
    private func parseFrame (_ data: Data) -> CGImage? {
        
        guard let imgProvider = CGDataProvider.init(data: data as CFData) else {
            handler?(nil, .parseImage)
            return nil
        }
        
        guard let image = CGImage.init(jpegDataProviderSource: imgProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) else {
            handler?(nil, .parseImage)
            return nil
        }
        return image
        
        
        
    }
    
    
    
}

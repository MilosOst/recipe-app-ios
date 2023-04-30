//
//  MultipartDataManager.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import UIKit

class MultipartDataManager {
    static let shared = MultipartDataManager()
    private let boundary = "Boundary-\(UUID().uuidString)"
    
    private init() { }
    
    func generateRequest(image: UIImage, url: URL) -> URLRequest {
        let body = generateBody(image: image)
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = body
        req.setValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
        
        return req
    }
    
    private func generateBody(image: UIImage) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let uuid = UUID().uuidString.components(separatedBy: "-").first {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(uuid).jpg\"\(lineBreak)")
            body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
            body.append(image.jpegData(compressionQuality: 0.99)!)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}

//
//  JEHTTPContent.swift
//  
//
//  Created by Jay Zisch on 2023/02/21.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

public struct JEHTTPContent {
    enum ImageTypes {
        case jpg, png
    }

    let type: JEHTTPMIMEType
    let body: Data
    
    init(type: JEHTTPMIMEType,
         body: Data) {
        self.type = type
        self.body = body
    }
    
    init?(json: [String: AnyObject]) {
        guard let data = try? JSONSerialization
            .data(withJSONObject: json) else { return nil }
        self.type = .json
        self.body = data
    }
    init?(object: Codable) {
        guard let data = try? JSONEncoder()
            .encode(object) else { return nil }
        self.type = .json
        self.body = data
    }
    
    init?(image: UIImage, imageType: ImageTypes) {
        switch imageType {
        case .jpg:
            guard let imageData = image
                .jpegData(compressionQuality: 1.0)?
                .base64EncodedData() else { return nil }
            type = .jpeg
            body = imageData
        case .png:
            guard let pngData = image
                .pngData()?
                .base64EncodedData() else { return nil }
            type = .png
            body = pngData
        }
    }
    
    /// [reference](https://www.donnywals.com/uploading-images-and-forms-to-a-server-using-urlsession/)
    ///
    /// [Content-Transfer-Encoding]https://www.w3.org/Protocols/rfc1341/5_Content-Transfer-Encoding.html
    init?(multipartFormData: [String: Any]) {
        
        let boundary: String = UUID().uuidString
        let httpBody = NSMutableData()
        let newLine = "\r\n"
        func textFormField(
            named name: String,
            value: String
        ) -> Data? {
            var fieldString = "--\(boundary)\(newLine)"
            fieldString += "Content-Disposition: form-data; name=\"\(name)\"\(newLine)"
            fieldString += "Content-Type: text/plain; charset=ISO-8859-1\(newLine)"
            fieldString += "Content-Transfer-Encoding: 8bit\(newLine)"
            fieldString += newLine
            fieldString += "\(value)\(newLine)"
            return fieldString.data(using: .utf8)
        }
        
        func dataFormField(
            named name: String,
            data: JEHTTPContent
        ) -> Data {
            let fieldData = NSMutableData()

            fieldData.append("--\(boundary)\(newLine)")
            fieldData.append("Content-Disposition: form-data; name=\"\(name)\"\(newLine)")
            fieldData.append("Content-Type: \(data.type)\(newLine)")
            fieldData.append(newLine)
            fieldData.append(data.body)
            fieldData.append(newLine)

            return fieldData as Data
        }
        
        for (name, value) in multipartFormData {
            if let data = value as? JEHTTPContent {
                httpBody.append(dataFormField(named: name, data: data))
            } else if let text = value as? String,
                      let asData = textFormField(named: name, value: text){
                httpBody.append(asData)
            }
        }
        
        httpBody.append("--\(boundary)--")
        type = .multiFormData(with: boundary)
        body = httpBody as Data
    }
}

private extension NSMutableData {
    func append(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        append(data)
    }
}



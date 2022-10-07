//
//  JWTManager.swift
//  JWTSample
//
//  Created by iMac on 2022/10/06.
//

import Foundation
import CryptoSwift
import CryptoKit
import SwiftJWT

struct Header: Encodable {
    let alg = "HS256"
    let typ = "JWT"
}

struct Payload: Encodable {
    var csno: String = "891122"
    var usid: String = "davidyoon"
    var exp: String = ""
    var iat: String = String(Date().timeIntervalSince1970)
    
    init(csno: String, usid: String, exp: String, iat: String) {
        self.csno = csno
        self.usid = usid
        self.exp = exp
        self.iat = iat
    }
}


class JWTGenerator {
    static func generateJWT() {
        let secret = "01234567890123456789012345678901"
        
        guard let headerJSONData = try? JSONEncoder().encode(Header()) else { return }
        let headerBase64String = headerJSONData.urlSafeBase64EncodedString()
        
        let calendar = Calendar.current
        let currentDate = Date()
        guard let expDate = calendar.date(byAdding: .minute, value: 20, to: currentDate) else { return }
        
        
        
        let payload = Payload(csno: "111111", usid: "qqpo13", exp: String(currentDate.timeIntervalSince1970), iat: String(expDate.timeIntervalSince1970))
        guard let payloadJSONData = try? JSONEncoder().encode(payload) else { return }
        let payloadBase64String = payloadJSONData.urlSafeBase64EncodedString()
        
        let toSign = Data((headerBase64String + "." + payloadBase64String).utf8)
        print("message: \((headerBase64String + "." + payloadBase64String).utf8)")
        
        guard let signature = try? HMAC.init(key: secret, variant: .sha2(.sha256)).authenticate(toSign.bytes) else { return }
        let signatureBase64String = Data(signature).urlSafeBase64EncodedString()
        print("signatureBase64String : \(signatureBase64String)")
        
        let token = [headerBase64String, payloadBase64String, signatureBase64String].joined(separator: ".")
        print(token)
    }
    
}




extension Data {
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString().replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}



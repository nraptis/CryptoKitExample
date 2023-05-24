//
//  Crypt.swift
//  CryptoKitExampleCLPB
//
//  Created by Tiger Nixon on 5/3/23.
//

import Foundation
import CryptoKit

enum CryptError: Error {
    case generic
}

struct Crypt {
    
    private lazy var keyData: Data = { Data(hexString: "de4db33f4ba05ea7cb5b311db55fad8f361147267b00c7a3d4a3fea8889eb33f") }()
    private lazy var key: SymmetricKey = { SymmetricKey(data: keyData) }()
    private lazy var nonceData: Data = { Data(hexString: "d33ff8cfead3eafceeafc8b2") }()
    
    mutating func encrypt(data: Data) throws -> Data {
        let nonce = try AES.GCM.Nonce(data: nonceData)
        let sealedData = try AES.GCM.seal(data, using: key, nonce: nonce)
        if let encryptedData = sealedData.combined {
            return encryptedData
        } else {
            throw CryptError.generic
        }
    }
    
    mutating func decrypt(data: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return decryptedData
    }
    
}

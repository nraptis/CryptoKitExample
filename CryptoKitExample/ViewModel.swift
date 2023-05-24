//
//  ViewModel.swift
//  CryptoKitExampleCLPB
//
//  Created by Tiger Nixon on 5/3/23.
//

import Foundation

actor ViewModel: ObservableObject {
    
    @MainActor @Published var plainText = "Diablo 4, coming in June"
    @MainActor @Published var encryptedText = ""
    
    private var crypt = Crypt()
    
    func encrypt() async {
        
        do {
            guard let data = await plainText.data(using: .utf8) else { return }
            
            let encryptedData = try crypt.encrypt(data: data)
            
            Task { @MainActor in
                encryptedText = encryptedData.hexString
                plainText = ""
            }
        } catch let error {
            print("encryption error: \(error.localizedDescription)")
        }
        
    }
    
    func decrypt() async {
        do {
            
            let data = await Data(hexString: encryptedText)
            
            let decryptedData = try crypt.decrypt(data: data)
            Task { @MainActor in
                plainText = String(data: decryptedData, encoding: .utf8) ?? ""
                encryptedText = ""
                
            }
            
            
        } catch let error {
            print("decryption error: \(error.localizedDescription)")
        }
    }
    
}

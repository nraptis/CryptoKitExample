//
//  ContentView.swift
//  CryptoKitExampleCLPB
//
//  Created by Tiger Nixon on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("Data To Encrypt", text: $viewModel.plainText)
                .textFieldStyle(.roundedBorder)
            TextField("Data To Descrypt", text: $viewModel.encryptedText)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button {
                    Task {
                        await viewModel.encrypt()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Encrypt")
                            .padding(.all, 4.0)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                Button {
                    Task {
                        await viewModel.decrypt()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Decrypt")
                            .padding(.all, 4.0)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

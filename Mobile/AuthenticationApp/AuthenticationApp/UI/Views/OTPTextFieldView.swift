//
//  OTPTextFieldView.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 20/09/23.
//

import SwiftUI

struct OTPTextFieldView: View {
    @State private var inputs = Array(repeating: "", count: 6)
    @FocusState private var focusFields : Int?
    var body: some View {
        HStack{
            ForEach(0..<6, id: \.self) { index in
                TextField("",text: $inputs[index]).frame(width: 40, height: 40).background(Color.gray.opacity(0.3)).keyboardType(.numberPad).cornerRadius(8).multilineTextAlignment(.center).focused($focusFields, equals: index).tag(index).onChange(of: inputs[index]) { newValue in
                    
                    if inputs[index].count > 1 {
                        inputs[index] = String(inputs[index].suffix(1))
                    }
                    if !newValue.isEmpty {
                        if index == 5 {
                            focusFields = nil
                        }
                        else{
                            focusFields = (focusFields ?? 0) + 1
                        }
                    }
                    else {
                        focusFields = (focusFields ?? 0) - 1
                    }
                }
            }
        }
    }
}

struct OTPTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextFieldView()
    }
}

//
//  ResetPasswordView.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 09/09/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var password: String = ""
    @StateObject var router = Router.shared
    var body: some View {
        ZStack{
            Color.gray.opacity(0.5).ignoresSafeArea()
            VStack(alignment:.center){
                Spacer()
                Text(strings.RESET_PASSWORD)
                    .bold().font(.largeTitle)
                TextField(strings.NEW_PASSWORD, text: $password).padding()
                    .autocorrectionDisabled(true)
                    .overlay(RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.4)))
                    .padding()
                Button {
                    
                } label: {
                    Text(strings.REQUEST_RESET).font(.title2).padding()
                        .frame(width: 320)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(30)
                }.padding()
                Spacer()
                Image(imageStrings.RESET_PASSWORD).resizable().scaledToFit().frame(alignment: .bottom)
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                router.path.removeLast()
            }, label: {
                Image(systemName:imageStrings.BACK_BUTTON).imageScale(.large).foregroundColor(.black)
            }))
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}

//
//  MyBackButton.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/11/23.
//

import SwiftUI

struct MyBackButton: View {
    let label: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            
        }) {
            HStack {
                Image(systemName: "restart.circle.fill")
                Text(label)
            }
        }
    }
}

//struct MyBackButton_Previews: PreviewProvider {
//    static var previews: some View {
//        MyBackButton()
//    }
//}

//
//  CoordinateView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct CoordinateView: View {
    let gridSize  = 10
    
//    let columnText: [Int] = [1,2,3,4,5,6,7,8,9,10]
//    let rowText:[Character] = ["A","B","C","D","E","F","G","H","I","J"]
    var text: String
    
    var body: some View {
        Text("\(text)")
          //  .frame(width: getButtonSize(), height: getButtonSize())
            .frame(width: 37,height: 37)
    }
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        print("buttonSize = \(size)")
        return CGFloat(size)
    }
}

struct CoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinateView(text: "A")
    }
}

//
//  CellView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI
import Foundation

struct CellView: View {
    
    let gridSize = 10
    
    var row: Int
    var col: Int
    @Binding var selectedRow: Int
    @Binding var selectedCol: Int
    @Binding var blockState: [[CellStatus]]
    
    var body: some View {
          
        Text("A")
           .frame(width: getButtonSize(), height: getButtonSize())
          // .frame(width: 20,height: 20)
           .background(.cyan)
           .border(.black, width:0.5)
           .onTapGesture {
               withAnimation {
                   //set seletedBlock Index
                   selectedRow = row
                   selectedCol = col
               }
           }
    }
    
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        print("buttonSize = \(size)")
        return CGFloat(size)
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CellView(row: 0, col: 0, selectedRow: .constant(0), selectedCol: .constant(0), blockState: .constant[[]])
//    }
//}

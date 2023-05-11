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
        
        Text("")
            .frame(width: getButtonSize(), height: getButtonSize())
            .background(blockState[row][col].bgColor)
            .border(blockState[row][col].isSelected ? .yellow : .black, width: blockState[row][col].isSelected ? 3 : 0.5)
            .onTapGesture {
                withAnimation {
                    //set seletedBlock Index
                    selectedRow = row
                    selectedCol = col
                    print("selected Row is \(selectedRow), Col is \(selectedCol)")
                    
                    //clear previous states
                    for (row, rowBlock) in blockState.enumerated() {
                        for (col, _) in rowBlock.enumerated() {
                            //  blockState[row][col].bgColor = .white
                            blockState[row][col].isSelected = false
                        }
                    }
                    
                    //set selected blocks states to be highlight
                    blockState[row][col].isSelected = true
                }
            }
    }
    
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        //  print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        //  print("buttonSize = \(size)")
        return CGFloat(size)
    }
}

//struct CellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CellView(row: 0, col: 0, selectedRow: .constant(0), selectedCol: .constant(0), blockState: .constant[[]])
//    }
//}

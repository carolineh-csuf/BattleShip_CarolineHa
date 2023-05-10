//
//  ContentView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct ContentView: View {
    let gridSize = 10
    let columnText: [String] = ["","1","2","3","4","5","6","7","8","9","10"]
    let rowText:[Character] = ["A","B","C","D","E","F","G","H","I","J"]
    
    @Binding var blockTextStruct: [[CellStatus]]
    
    @State var selectedRow = 0
    @State var selectedCol = 0
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                HStack(spacing:0) {
                    ForEach(Array(columnText.enumerated()), id: \.offset) { (columnIndex, value) in
                        CoordinateView(text:value)
                    }
                }
                
                ForEach(Array(rowText.enumerated()), id: \.offset) { (rowIndex, value) in
                    VStack(spacing:0) {
                        HStack(spacing: 0){
                            CoordinateView(text: String(value))
                            Spacer()
                        }
                    }
                }
            }
            
            VStack(spacing: 0) {
                ForEach(0..<gridSize) { row in
                    HStack(spacing:0) {
                        ForEach(0..<gridSize) { column in
                            CellView(row: row, col: column, selectedRow: $selectedRow, selectedCol: $selectedCol, blockState: $blockTextStruct)
                        }
                    }
                }
            }
            .offset(x: getButtonSize()/2 ,y: getButtonSize()/2)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        print("buttonSize = \(size)")
        return CGFloat(size)
    }
    
    func createBlock(_ row: Int,_ col: Int) -> CellView {
        
        return CellView(
            row: row,
            col: col,
            selectedRow: $selectedRow,
            selectedCol: $selectedCol,
            blockState: $blockTextStruct
        )
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      ContentView()
//    }
//}

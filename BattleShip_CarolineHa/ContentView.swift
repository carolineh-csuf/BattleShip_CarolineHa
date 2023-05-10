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
        // ZStack {
        VStack(spacing:0) {
            HStack(spacing:0) {
                ForEach(Array(columnText.enumerated()), id: \.offset) { (columnIndex, value) in
                    CoordinateView(text:value)
                }
            }
            
          //  VStack(spacing: 0) {
            ZStack {

                VStack(spacing: 0) {
                        ForEach(0..<gridSize) { row in
                            HStack(spacing:0) {
                                    ForEach(0..<gridSize) { column in
                                        CellView(row: row, col: column, selectedRow: $selectedRow, selectedCol: $selectedCol, blockState: $blockTextStruct)
                                        }
                                    }
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
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // }
    }
    
    //        VStack(spacing: 0) {
    //            ForEach(Array(blockTextStruct.enumerated()), id: \.offset) { (rowIndex, row) in
    //                HStack(spacing:0) {
    //                    ForEach(Array(row.enumerated()), id: \.offset) { (columnIndex, value) in
    //                            createBlock(rowIndex, columnIndex)
    //                    }
    //                }
    //
    //            }
    //        }
    //  .frame(maxWidth: .infinity, maxHeight: .infinity)
    //  }
    
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

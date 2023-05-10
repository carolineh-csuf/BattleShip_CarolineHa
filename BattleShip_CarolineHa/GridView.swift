//
//  GridView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct GridView: View {
    let gridSize = 10
    
    var row: Int
    var col: Int
    @Binding var selectedRow: Int
    @Binding var selectedCol: Int
    @Binding var blockState: [[CellStatus]]
    
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<gridSize) { row in
                HStack(spacing:0) {
                    ForEach(0..<gridSize) { column in
                        CellView(row: row, col: column, selectedRow: $selectedRow, selectedCol: $selectedCol, blockState: $blockState)
                    }
                }
            }
        }
    }
}

//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView()
//    }
//}

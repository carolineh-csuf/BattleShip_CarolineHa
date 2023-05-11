//
//  OpponentCellView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct OpponentCellView: View {
    let gridSize = 10
    
    var row: Int
    var col: Int
    @Binding var selectedOpponentRow: Int
    @Binding var selectedOpponentCol: Int
    @Binding var blockState: [[CellStatus]]
    @Binding var shipType: CellStatus.ShipType!
    @Binding var currentPlayer: String
    @Binding var message: String
//    @Binding var isAnimating5: Bool
//    @Binding var isAnimating4: Bool
//    @Binding var isAnimating3: Bool
//    @Binding var isAnimating2: Bool
//    @Binding var isAnimating1: Bool
    
    @State private var isAttacked: Bool = false
    
    var body: some View {
        Text(blockState[row][col].cellText)
            .frame(width: getButtonSize(), height: getButtonSize())
            .background(blockState[row][col].bgColor)
            .border(blockState[row][col].isSelected ? .yellow : .black, width: blockState[row][col].isSelected ? 3 : 0.5)
            .onTapGesture {
                withAnimation {
                    //set seletedBlock Index
                    selectedOpponentRow = row
                    selectedOpponentCol = col
                    
                    //check if attacked
                            if blockState[selectedOpponentRow][selectedOpponentCol].bgColor == .pink {
                                isAttacked = true
                                return
                            }

                    
                    //set selected blocks states to be highlight
                    blockState[row][col].bgColor = .yellow
                    //blockState[row][col].cellText = "A"
                    
                    message = "Attracking Opponent at Coordinate(x: \(selectedOpponentRow) ,y: \(selectedOpponentCol)"
                    print("Attracking Opponent at Row: \(selectedOpponentRow), Col: \(selectedOpponentCol)")
                    
                    
                    for (row, rowBlock) in blockState.enumerated() {
                        for (col, _) in rowBlock.enumerated() {
                            blockState[selectedOpponentRow][selectedOpponentCol].bgColor = .pink
                            blockState[selectedOpponentRow][selectedOpponentCol].cellText = "A"
                        }
                    }
                    
                    //give turn to Opponent
                    currentPlayer = "Opponent"
                    print("Give turn to player: \(currentPlayer)")
                }
            }
            .alert("You already attack this area.", isPresented: $isAttacked){
                Button("OK") { isAttacked = false}
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

//struct OpponentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpponentCellView()
//    }
//}

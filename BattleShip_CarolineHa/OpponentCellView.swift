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
    @Binding var isWaitingForAttack: Bool
    @Binding var opponentHitCount: Int
    
    @State private var isAttacked: Bool = false
    @State private var showInvalidTapAlert: Bool = false
    
    @State private var opponentResponse: String = ""
    
    var body: some View {
        Text(blockState[row][col].cellText)
            .frame(width: getButtonSize(), height: getButtonSize())
            .background(blockState[row][col].bgColor)
            .border(blockState[row][col].isSelected ? .yellow : .black, width: blockState[row][col].isSelected ? 3 : 0.5)
        //            .onChange(of: opponentHitCount) { newValue in
        //                print("hitCount : \(opponentHitCount)")
        //            }
            .onTapGesture {
                // print("hitCount is \(hitCount)")
                withAnimation {
                    if isWaitingForAttack {
                        showInvalidTapAlert = true
                        return
                    }
                    
                    //set seletedBlock Index
                    selectedOpponentRow = row
                    selectedOpponentCol = col
                    
                    //check if attacked
                    if blockState[selectedOpponentRow][selectedOpponentCol].bgColor == .pink {
                        isAttacked = true
                        return
                    }
                    
                    message = "Attacking Opponent at  \(Character(UnicodeScalar(selectedOpponentRow + 65)!))\(selectedOpponentCol + 1)."
                    // print("Attracking Opponent at Row: \(selectedOpponentRow), Col: \(selectedOpponentCol)")
                    
                    for (_, rowBlock) in blockState.enumerated() {
                        for (_, _) in rowBlock.enumerated() {
                            if  blockState[selectedOpponentRow][selectedOpponentCol].cellHiddenText == "X" {
                                blockState[selectedOpponentRow][selectedOpponentCol].bgColor = .pink
                                blockState[selectedOpponentRow][selectedOpponentCol].cellText = "O"
                                
                                opponentResponse =  "--------Hit ✌️"
                                
                            } else {
                                blockState[selectedOpponentRow][selectedOpponentCol].bgColor = .gray
                                blockState[selectedOpponentRow][selectedOpponentCol].cellText = "X"
                                
                                opponentResponse = "--------Miss 😢"
                            }
                        }
                    }
                    
                    //update message
                    message = message + opponentResponse
                    
                    //update hitCount
                    if  blockState[selectedOpponentRow][selectedOpponentCol].cellHiddenText == "X" {
                        opponentHitCount += 1
                    }
                    
                    //give turn to Opponent
                    currentPlayer = "Opponent"
                  //  print("Give turn to player: \(currentPlayer)")
                }
            }
            .alert("You already attack this area.", isPresented: $isAttacked){
                Button("OK") { isAttacked = false}
            }
            .alert("Please waiting for attack.", isPresented: $showInvalidTapAlert) {
                Button("OK") {
                    showInvalidTapAlert = false
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

//struct OpponentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpponentCellView()
//    }
//}

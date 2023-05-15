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
    @Binding var numberOfPlayerMiss: Int
    
    @State private var isAttacked: Bool = false
    @State private var showInvalidTapAlert: Bool = false
    
    @State private var opponentResponse: String = ""
    
    //for opponent
//    @State private var attackCountforCarrier: Int = 0
//    @State private var attackCountforBattleShip: Int = 0
//    @State private var attackCountforCruiser: Int = 0
//    @State private var attackCountforSubmarine: Int = 0
//    @State private var attackCountforDestroyer: Int = 0
//    @State private var showOpponentSunkShipAlert: Bool = false
//    @State private var sunkShipAlertText: String = ""
    
    
    var body: some View {
        Text(blockState[row][col].cellText)
            .frame(width: getButtonSize(), height: getButtonSize())
            .background(blockState[row][col].bgColor)
            .border(blockState[row][col].isSelected ? .yellow : .black, width: blockState[row][col].isSelected ? 3 : 0.5)
//                    .onChange(of: opponentHitCount) { newValue in
//                        print("Opponent HitCount : \(opponentHitCount)")
//                        print("Hit block type is: \(blockState[row][col].shipType)")
//                    }
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
                    
                    message = "You attacked Opponent at  \(Character(UnicodeScalar(selectedOpponentRow + 65)!))\(selectedOpponentCol + 1)."
                    // print("Attracking Opponent at Row: \(selectedOpponentRow), Col: \(selectedOpponentCol)")
                    
                    for (_, rowBlock) in blockState.enumerated() {
                        for (_, _) in rowBlock.enumerated() {
                            if  blockState[selectedOpponentRow][selectedOpponentCol].cellHiddenText == "X" {
                                blockState[selectedOpponentRow][selectedOpponentCol].bgColor = .pink
                                blockState[selectedOpponentRow][selectedOpponentCol].cellText = "O"
                                
                                opponentResponse =  "Hit ✌️"
                                
                            } else {
                                blockState[selectedOpponentRow][selectedOpponentCol].bgColor = .gray
                                blockState[selectedOpponentRow][selectedOpponentCol].cellText = "X"
                                opponentResponse = "Miss 😢"
                            }
                        }
                    }
                    
                    //update message
                    message = message + "--------" + opponentResponse
            
                    //update hitCount
                    if  blockState[selectedOpponentRow][selectedOpponentCol].cellHiddenText == "X" {
                        opponentHitCount += 1
                    
                       // checkOpponentShipStatus(shipType: blockState[selectedOpponentRow][selectedOpponentCol].shipType)
                    } else {
                        numberOfPlayerMiss += 1
                    }
                    
                    //give turn to Opponent
                    currentPlayer = "Opponent"
                  //  print("Give turn to player: \(currentPlayer)")
                }
            }
            .alert("You had attacked this area.", isPresented: $isAttacked){
                Button("OK") { isAttacked = false}
            }
            .alert("Please waiting for your turn.", isPresented: $showInvalidTapAlert) {
                Button("OK") {
                    showInvalidTapAlert = false
                }
            }
//            .alert("Opponent \(sunkShipAlertText) sunk", isPresented: $showOpponentSunkShipAlert) {
//                Button("Dismiss") {
//                    showOpponentSunkShipAlert = false
//                  //  checkVictory() //check again for the last ship
//                }
//
//            }
    }
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        //  print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        //  print("buttonSize = \(size)")
        return CGFloat(size)
    }
    
//    func checkOpponentShipStatus(shipType: CellStatus.ShipType!) {
//
//        switch shipType {
//        case .carrier:
//            attackCountforCarrier += 1
//        case .battleShip:
//            attackCountforBattleShip += 1
//        case .cruiser:
//            attackCountforCruiser += 1
//        case .submarine:
//            attackCountforSubmarine += 1
//        case .Destoyer:
//            attackCountforDestroyer += 1
//        case .none:
//            break
//        }
//
//        if attackCountforCarrier == 5 {
//            showOpponentSunkShipAlert = true
//            sunkShipAlertText = "AirCraft Carrier"
//            attackCountforCarrier = 0
//        }
//
//        if attackCountforBattleShip == 4 {
//            showOpponentSunkShipAlert = true
//            sunkShipAlertText = "BattleShip"
//            attackCountforBattleShip = 0
//        }
//
//        if attackCountforSubmarine == 3 {
//            showOpponentSunkShipAlert = true
//            sunkShipAlertText = "Submarine"
//            attackCountforSubmarine = 0
//        }
//
//        if attackCountforCruiser == 3 {
//            showOpponentSunkShipAlert = true
//            sunkShipAlertText = "Cruiser"
//            attackCountforCruiser = 0
//        }
//
//        if attackCountforDestroyer == 2 {
//            showOpponentSunkShipAlert = true
//            sunkShipAlertText = "Destroyer"
//            attackCountforDestroyer = 0
//        }
//
//      //  checkVictory()
//
//    }
    
}

//struct OpponentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpponentCellView()
//    }
//}

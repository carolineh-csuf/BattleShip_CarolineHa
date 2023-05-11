//
//  GameView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct GameView: View {
    
    @Binding var blockTextStruct: [[CellStatus]]
    
    @State var opponentBlocks:[[CellStatus]] = [[.init(cellType: CellStatus.CellType.empty, isSelected: false, bgColor: .blue, cellText: "")]]
    
    let gridSize = 10
    let columnText: [String] = ["","1","2","3","4","5","6","7","8","9","10"]
    let rowText:[String] = ["A","B","C","D","E","F","G","H","I","J"]
    
    enum ShipDirection {
        case horizontal;
        case vertical;
    }
    
    @State var selectedRow = 0
    @State var selectedCol = 0
    
    
    @State private var selectedOpponentRow = 0
    @State private var selectedOpponentCol = 0
    
    @State private var selectedShip: CellStatus.ShipType! = nil
    @State private var selectedShipSize: Int = 0
    @State private var selectedShipDirection: ShipDirection = .horizontal
    
    @State private var isAnimating5: Bool = false
    @State private var isAnimating4: Bool = false
    @State private var isAnimating3: Bool = false
    @State private var isAnimating2: Bool = false
    @State private var isAnimating1: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Section {
                    Text("Score")
                        .padding(.top)
                    Text("Activities")
                }
                .offset(y: 8)
                
                
                VStack {
                    Section {
                        Text("Opponent")
//                            .padding(.top)
//                        Text("select attact coordinate:")
                    }
                    .offset(y:25)
                    
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
                                        CoordinateView(text: value)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        
                        VStack(spacing: 0) {
                            ForEach(Array(opponentBlocks.enumerated()), id: \.offset) { (rowIndex, row) in
                                //   ForEach(0..<gridSize) { row in
                                HStack(spacing:0) {
                                    ForEach(Array(row.enumerated()), id: \.offset) { (columnIndex, value) in
                                        // ForEach(0..<gridSize) { column in
                                        // CellView(row: rowIndex, col: columnIndex, selectedRow: $selectedOpponentRow, selectedCol: $selectedOpponentCol, blockState: $opponentBlocks, shipType: $selectedShip, isAnimating5: $isAnimating5, isAnimating4: $isAnimating4, isAnimating3: $isAnimating3, isAnimating2: $isAnimating2, isAnimating1: $isAnimating1)
                                        
                                        OpponentCellView(row: rowIndex, col: columnIndex, selectedOpponentRow: $selectedOpponentRow, selectedOpponentCol: $selectedOpponentCol, blockState: $opponentBlocks, shipType: $selectedShip)
                                    }
                                }
                            }
                        }
                        .offset(x: getButtonSize()/2 ,y: getButtonSize()/2)
                        .onAppear {
                            initializeOpponentBlocks()
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
                    .scaleEffect(0.9)
                    //.offset(x: -20 , y: -20)
                    
                }
                 
                VStack {
                    Section {
                        Text("Player")
                        //Text("select attact coordinate:")
                    }
                    .offset(y: -10)
                    
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
                                        CoordinateView(text: value)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        
                        VStack(spacing: 0) {
                            ForEach(Array(blockTextStruct.enumerated()), id: \.offset) { (rowIndex, row) in
                                //   ForEach(0..<gridSize) { row in
                                HStack(spacing:0) {
                                    ForEach(Array(row.enumerated()), id: \.offset) { (columnIndex, value) in
                                        // ForEach(0..<gridSize) { column in
                                        CellView(row: rowIndex, col: columnIndex, selectedRow: $selectedRow, selectedCol: $selectedCol, blockState: $blockTextStruct, shipType: $selectedShip, isAnimating5: $isAnimating5, isAnimating4: $isAnimating4, isAnimating3: $isAnimating3, isAnimating2: $isAnimating2, isAnimating1: $isAnimating1)
                                    }
                                }
                            }
                        }
                        .offset(x: getButtonSize()/2 ,y: getButtonSize()/2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.secondary)
                    .scaleEffect(0.8)
                    .offset(x: 5 , y: -65)
                    .onAppear {
                        preparePlayerboard(cellStatus: &blockTextStruct)
                    }
                    
               }
                
            }
            //.navigationTitle("Score:")
           // .navigationBarTitleDisplayMode(.inline)
            //        .toolbar {
            //            ToolbarItem(placement: .bottomBar) {
            //                Text("Display")
            //                    .background(.black)
            //            }
            //        }
            //        .background(.white)
            
            //            ToolbarItem(placement: .bottomBar) {
            //                Button(action: {
            //                   // self.showInfo = true
            //                }) {
            //                    VStack {
            //                        Image(systemName: "info.bubble")
            //                        Text("Info")
            //                            .font(.headline)
            //                            .foregroundColor(.black)
            //                        // .background(.lightBackground)
            //                    }
            //                }
            //            }
        }
    }
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        //      print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        //      print("buttonSize = \(size)")
        return CGFloat(size)
    }
    
    private func getGridFrameSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        print("screenHeight is \(screenHeight), width is \(screenWidth)")
      //  let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        let size = (Int(screenHeight) - 200) / 2
        print("frame size is \(size)")
        return CGFloat(size)
    }
    
    func initializeOpponentBlocks() {
        let numRows = gridSize
        let numColumns = gridSize
        
        opponentBlocks.removeAll()
        
        for _ in 0..<numRows {
            var row: [CellStatus] = []
            for _ in 0..<numColumns {
                var cellStatus = CellStatus(cellType: .empty, isSelected: false, bgColor: .white, cellText: "")
                row.append(cellStatus)
            }
            opponentBlocks.append(row)
        }
    }
    
    
    func opponentBoardGenerator() {
        
    }
    
    func preparePlayerboard(cellStatus: inout [[CellStatus]]) {
        for (row, rowBlock) in cellStatus.enumerated() {
            for (col, _) in rowBlock.enumerated() {
                if cellStatus[row][col].isSelected == true {
                    cellStatus[row][col].isSelected = false
                }
            }
        }
        
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

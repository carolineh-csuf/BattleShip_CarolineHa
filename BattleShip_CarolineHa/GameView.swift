//
//  GameView.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

struct GameView: View {
    
    @Binding var blockTextStruct: [[CellStatus]]
    @Binding var shipsCoordinate: [CellStatus.ShipType: [(Int,Int)]]
    
    
    let gridSize = 10
    let columnText: [String] = ["","1","2","3","4","5","6","7","8","9","10"]
    let rowText:[String] = ["A","B","C","D","E","F","G","H","I","J"]
    
    enum ShipDirection {
        case horizontal;
        case vertical;
    }
    
    @State var opponentBlocks:[[CellStatus]] = [[.init(cellType: CellStatus.CellType.empty, isSelected: false, bgColor: .blue, cellText: "")]]
    
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
    
    @State private var message: String = ""
    @State private var playerResponse: String = ""
    @State private var opponentResponse: String = ""
    
    @State private var opponentAttackCoordinates = Set<Coordinate>()
    @State private var players = ["Player", "Opponent"]
    
    @State var currentPlayerIndex: Int = 0
    @State var currentPlayer: String = ""
    
    @State var isIntheGame: Bool = false
    @State var isWaitingForAttack: Bool = false
    
    
    @State private var hitCountforCarrier: Int = 0
    @State private var hitCountforBattleShip: Int = 0
    @State private var hitCountforCruiser: Int = 0
    @State private var hitCountforSubmarine: Int = 0
    @State private var hitCountforDestroyer: Int = 0
    @State private var showSunkShipAlert: Bool = false
    @State private var sunkShipAlertText: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Section {
                    Text(currentPlayer == "Player" ? "Your turn" : "Waiting for Attack")
                        .foregroundColor(.blue)
                        .fontWeight(.heavy)
                        .onChange(of: currentPlayer) {newValue in
                            if newValue == "Opponent" {
                                isWaitingForAttack = true
                                
                                delay(seconds: 2) {
                                    receiveOpponentAttack()
                                    
                                    currentPlayer = "Player"
                                    isWaitingForAttack = false
                                }
                            }
                        }
                    // .animation(Animation.easeInOut(duration: 1.0).repeatForever())
                    
                    Text("\(message)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .minimumScaleFactor(0.5)
                        .font(.title)
                        .lineLimit(2)
                        .padding(5)
                    
                }
                .offset(y: 40)
                
                
                VStack {
                    Section {
                        Text("Opponent Score")
                    }
                    .offset(y:55)
                    
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
                                HStack(spacing:0) {
                                    ForEach(Array(row.enumerated()), id: \.offset) { (columnIndex, value) in
                                        OpponentCellView(row: rowIndex, col: columnIndex, selectedOpponentRow: $selectedOpponentRow, selectedOpponentCol: $selectedOpponentCol, blockState: $opponentBlocks, shipType: $selectedShip, currentPlayer: $currentPlayer, message: $message, isWaitingForAttack: $isWaitingForAttack)
                                    }
                                }
                            }
                        }
                        .offset(x: getButtonSize()/2 ,y: getButtonSize()/2)
                        .onAppear {
                            initializeOpponentBlocks()
                        }
                        .onTapGesture {
                            //  message = message +
                            // sendAttacktoOpponent()
                            // currentPlayerIndex = 1
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
                    .scaleEffect(0.8)
                    .offset(y: 5)
                    
                }
                
                Section {
                    Section {
                        Text("Player Score:")
                        //Text("select attact coordinate:")
                    }
                    .offset(y: 30)
                    
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
                                        CellView(row: rowIndex, col: columnIndex, selectedRow: $selectedRow, selectedCol: $selectedCol, blockState: $blockTextStruct, shipType: $selectedShip, isAnimating5: $isAnimating5, isAnimating4: $isAnimating4, isAnimating3: $isAnimating3, isAnimating2: $isAnimating2, isAnimating1: $isAnimating1, isIntheGame: $isIntheGame)
                                    }
                                }
                            }
                        }
                        .offset(x: getButtonSize()/2 ,y: getButtonSize()/2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.secondary)
                    .scaleEffect(0.8)
                    .offset(x: 5 , y: -20)
                    .onAppear {
                        isIntheGame = true
                        preparePlayerboard(cellStatus: &blockTextStruct)
                        for (key, value) in shipsCoordinate {
                            print("\(key): \(value)", terminator: " ")
                        }
                        
                        //checkShipStatus()
                    }
                    .alert("You sunk my \(sunkShipAlertText)", isPresented: $showSunkShipAlert) {
                        Button("Dissmis") { showSunkShipAlert = false }
                    }
                    
                }
                .offset(y: -50)
                
            }
            .offset(y: 30)
        }
        .onAppear {
            // Shuffle the players array
            players.shuffle()
            print("Game Started: \(currentPlayerIndex)")
            currentPlayer = players[currentPlayerIndex]
            
            prepareOpponentAttack(gridSize: gridSize)
            
            if currentPlayer == "Opponent" {
                delay(seconds: 2) {
                    receiveOpponentAttack()
                    
                    //give turn to player
                    currentPlayer = "Player"
                }
            }
        }
    }
    
    func delay(seconds: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
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
                let cellStatus = CellStatus(cellType: .empty, isSelected: false, bgColor: .white, cellText: "")
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
    
    func prepareOpponentAttack(gridSize: Int) {
        // Generate unique coordinates
        while opponentAttackCoordinates.count < gridSize * gridSize {
            let x = Int.random(in: 0..<gridSize)
            let y = Int.random(in: 0..<gridSize)
            let coordinate = Coordinate(x: x, y: y)
            opponentAttackCoordinates.insert(coordinate)
        }
        
        // Print the coordinates
        for _ in opponentAttackCoordinates {
            //    print(coordinate)
        }
    }
    
    func receiveOpponentAttack() {
        if let element = opponentAttackCoordinates.popFirst() {
            message = "Opponent attack you at: \(Character(UnicodeScalar(element.x + 65)!))\(element.y + 1)."
            
            //  print("Element:", element)
            
            //update player board status
            for (_, rowBlock) in blockTextStruct.enumerated() {
                for (_, _) in rowBlock.enumerated() {
                    if blockTextStruct[element.x][element.y].shipType != nil {
                        print("Hitted ship type : \(String(describing: blockTextStruct[element.x][element.y].shipType))")
                        blockTextStruct[element.x][element.y].cellText = "O"
                        blockTextStruct[element.x][element.y].bgColor = .red
                        
                        //   if blockTextStruct[element.x][element.y].cellText == "O" {
                        //                            switch blockTextStruct[element.x][element.y].shipType {
                        //                            case .carrier:
                        //                                hitCountforCarrier += 1
                        //                            case .battleShip:
                        //                                hitCountforBattleShip += 1
                        //                            case .cruiser:
                        //                                hitCountforCruiser += 1
                        //                            case .submarine:
                        //                                hitCountforSubmarine += 1
                        //                            case .Destoyer:
                        //                                hitCountforDestroyer += 1
                        //                            case .none:
                        //                                break
                        //                            }
                        
                      //  checkShipStatus(shipType: blockTextStruct[element.x][element.y].shipType ?? nil)
                        //   }
                        playerResponse = "Hit ✌️"
                        
                    } else {
                        blockTextStruct[element.x][element.y].cellText = "X"
                        blockTextStruct[element.x][element.y].bgColor = .white
                        playerResponse = "Miss 😢"
                    }
                }
            }
            
            if blockTextStruct[element.x][element.y].cellText == "O" {
                checkShipStatus(shipType: blockTextStruct[element.x][element.y].shipType ?? nil)
            }
            
            if playerResponse != "" {
                message = message + " --------- " + playerResponse
            }
            
        }
        
        //   print("Remaining Set:", opponentAttackCoordinates)
    }
    
    func checkShipStatus(shipType: CellStatus.ShipType!) {
        print("check ship Type : \(String(describing: shipType))")
        switch shipType {
        case .carrier:
            hitCountforCarrier += 1
        case .battleShip:
            hitCountforBattleShip += 1
        case .cruiser:
            hitCountforCruiser += 1
        case .submarine:
            hitCountforSubmarine += 1
        case .Destoyer:
            hitCountforDestroyer += 1
        case .none:
            break
        }
        
        
        
        if hitCountforCarrier == 5 {
            showSunkShipAlert = true
            sunkShipAlertText = "AirCraft Carrier"
            hitCountforCarrier = 0
        }
        
        if hitCountforBattleShip == 4 {
            showSunkShipAlert = true
            sunkShipAlertText = "BattleShip"
            hitCountforBattleShip = 0
        }
        
        if hitCountforSubmarine == 3 {
            showSunkShipAlert = true
            sunkShipAlertText = "Submarine"
            hitCountforSubmarine = 0
        }
        
        if hitCountforCruiser == 3 {
            showSunkShipAlert = true
            sunkShipAlertText = "Cruiser"
            hitCountforCruiser = 0
        }
        
        if hitCountforDestroyer == 2 {
            showSunkShipAlert = true
            sunkShipAlertText = "Destroyer"
            hitCountforDestroyer = 0
        }
        
    }
    
}



//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

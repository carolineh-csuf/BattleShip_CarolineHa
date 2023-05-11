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
    let rowText:[String] = ["A","B","C","D","E","F","G","H","I","J"]
    
    enum ShipDirection {
        case horizontal;
        case vertical;
    }
    
    // @Binding var blockTextStruct: [[CellStatus]]
    
    @State var blockTextStruct:[[CellStatus]] = [[.init(cellType: CellStatus.CellType.empty, isSelected: false, bgColor: .blue)]]
    
    @State var selectedRow = 0
    @State var selectedCol = 0
    
    @State private var selectedShip: CellStatus.ShipType! = nil
    @State private var selectedShipSize: Int = 0
    @State private var selectedShipDirection: ShipDirection = .horizontal
    
    @State private var isAnimating5: Bool = false
    @State private var isAnimating4: Bool = false
    @State private var isAnimating3: Bool = false
    @State private var isAnimating2: Bool = false
    @State private var isAnimating1: Bool = false
    //   @State private var isSelectedShip: Bool = false
    @State private var isHorizontal: Bool = false
    @State private var showAlert: Bool = false
    //    @State private var isToggleEnabled = false
    
    var body: some View {
        
        NavigationView {
            VStack {
            //    NavigationLink(destination: GameView()) {
                    
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
                        .onAppear {
                            initializeBlockTextStruct()
                        }
                        .alert("Overlapped, Invalid Placement", isPresented: $showAlert) {
                            Button("OK") {
                                showAlert = false
                                print("showAlert: \(showAlert)")
                            }
                        }
                        //                .onChange(of: blockTextStruct[selectedRow][selectedCol].isSelected) {newValue in
                        //
                        //                    getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: selectedShipDirection, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                        //                }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.secondary)
                    
                    
            //    }
                    
                HStack {
                    Text("Your Fleet:")
                        .font(.title2)
                    HStack {
                        Text("Ship Direction:")
                        
                        Toggle(isHorizontal ? "Horizontal" : "Vertical", isOn: $isHorizontal)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            .frame(width: 140)
                            .onChange(of: isHorizontal) { newValue in
                                selectedShipDirection = newValue ? .horizontal : .vertical
                                // Handle toggle state change
                                print("Toggle Horizontal direction to: \(newValue)")
                                print("selectedShipDirection: \(selectedShipDirection)")
                                getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: selectedShipDirection, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                            }
                            .disabled(selectedShip == nil || selectedShipSize == 1)
                        //                        .alert("You must select a ship first.", isPresented: $isToggleEnabled) {
                        //                            Button("OK") {
                        //                                isToggleEnabled.toggle()
                        //                            }
                        //                        }
                    }
                    .opacity(selectedShip == nil || selectedShipSize == 1 ? 0.2 : 1.0)
                    
                }
                
                HStack() {
                    Button(action: {
                        withAnimation {
                            isAnimating5.toggle()
                            isAnimating4 = false
                            isAnimating3 = false
                            isAnimating2 = false
                            isAnimating1 = false
                            
                            selectedShip = .carrier
                            selectedShipSize = 5
                            
                            getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: isHorizontal ? ShipDirection.horizontal : ShipDirection.vertical, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                        }
                    }){
                        HStack{
                            Text("Carrier: ")
                            HStack(spacing:0){
                                Image(systemName: "train.side.rear.car")
                                Image(systemName: "train.side.middle.car")
                                Image(systemName: "train.side.middle.car")
                                Image(systemName: "train.side.middle.car")
                                Image(systemName: "train.side.front.car")
                            }
                        }
                        .padding()
                    }
                    .buttonStyle(BoldButtonStyle(isAnimating: isAnimating5))
                    .padding(.trailing)
                    
                    //                Toggle(isHorizontal ? "Horizontal" : "Vertical", isOn: $isHorizontal)
                    //                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    //                    .frame(width: 140)
                    //                    .onChange(of: isHorizontal) { newValue in
                    //                       selectedShipDirection = newValue ? .horizontal : .vertical
                    //                        // Handle toggle state change
                    //                        print("Toggle Horizontal direction to: \(newValue)")
                    //                        print("selectedShipDirection: \(selectedShipDirection)")
                    //                        getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: selectedShipDirection, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                    //                    }
                }
                
                Button(action: {
                    withAnimation {
                        isAnimating4.toggle()
                        isAnimating5 = false
                        isAnimating3 = false
                        isAnimating2 = false
                        isAnimating1 = false
                        
                        selectedShip = .battleShip
                        selectedShipSize = 4
                        
                        getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: isHorizontal ? ShipDirection.horizontal : ShipDirection.vertical, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                    }
                }){
                    HStack {
                        Text("BattleShip: size 4")
                        HStack(spacing:0){
                            Image(systemName: "train.side.rear.car")
                            Image(systemName: "train.side.middle.car")
                            Image(systemName: "train.side.middle.car")
                            Image(systemName: "train.side.front.car")
                        }
                    }
                    .padding()
                }
                .buttonStyle(BoldButtonStyle(isAnimating: isAnimating4))
                .padding(.trailing)
                
                Button(action: {
                    withAnimation {
                        isAnimating3.toggle()
                        isAnimating5 = false
                        isAnimating4 = false
                        isAnimating2 = false
                        isAnimating1 = false
                        
                        selectedShip = .cruiser
                        selectedShipSize = 3
                        
                        getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: isHorizontal ? ShipDirection.horizontal : ShipDirection.vertical, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                    }
                }){
                    HStack {
                        Text("Cruiser: size 3")
                        HStack(spacing: 0){
                            Image(systemName: "train.side.rear.car")
                            Image(systemName: "train.side.middle.car")
                            Image(systemName: "train.side.front.car")
                        }
                    }
                    .padding()
                }
                .buttonStyle(BoldButtonStyle(isAnimating: isAnimating3))
                .padding(.trailing)
                
                Button(action: {
                    withAnimation {
                        isAnimating2.toggle()
                        isAnimating5 = false
                        isAnimating4 = false
                        isAnimating3 = false
                        isAnimating1 = false
                        
                        selectedShip = .Destoyer
                        selectedShipSize = 2
                        
                        getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: isHorizontal ? ShipDirection.horizontal : ShipDirection.vertical, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                    }
                }){
                    HStack {
                        Text("Destroyer: size 2")
                        HStack(spacing:0){
                            Image(systemName: "train.side.rear.car")
                            Image(systemName: "train.side.front.car")
                        }
                    }
                    .padding()
                }
                .buttonStyle(BoldButtonStyle(isAnimating: isAnimating2))
                .padding(.trailing)
                
                Button(action: {
                    withAnimation {
                        isAnimating1.toggle()
                        isAnimating5 = false
                        isAnimating4 = false
                        isAnimating3 = false
                        isAnimating2 = false
                        
                        selectedShip = .submarine
                        selectedShipSize = 1
                        
                        getShipCoordinate(selectedShip, shipSize: selectedShipSize, shipDirection: isHorizontal ? ShipDirection.horizontal : ShipDirection.vertical, row: selectedRow, col: selectedCol, blockState: &blockTextStruct)
                    }
                }){
                    HStack {
                        Text("Submarine size 1")
                        HStack(spacing:0){
                            // Image(systemName: "train.side.rear.car")
                            Image(systemName: "train.side.front.car")
                        }
                    }
                    .padding()
                }
                .buttonStyle(BoldButtonStyle(isAnimating: isAnimating1))
                .padding(.trailing)
                
                Spacer()
                HStack {
                    Button(action: {
                        initializeBlockTextStruct()
                        isAnimating5 = false
                        
                    }){ Text("Reset Board")
                            .foregroundColor(.red)
                    }
                    .padding()
                    Spacer()

                    NavigationLink(destination: GameView()) {
                        Text("Start Game")
                            .padding()
                    }
                    
                }
                
            }
//            .navigationTitle("BattleShip")
//            .padding()
        }
        
    }
    
    func initializeBlockTextStruct() {
        let numRows = gridSize
        let numColumns = gridSize
        
        blockTextStruct.removeAll()
        
        for _ in 0..<numRows {
            var row: [CellStatus] = []
            for _ in 0..<numColumns {
                var cellStatus = CellStatus(cellType: .empty, isSelected: false, bgColor: .blue)
                row.append(cellStatus)
            }
            blockTextStruct.append(row)
        }
    }
    
    private func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        //      print("screenWidth is : \(screenWidth)")
        let size = (Int(screenWidth) - (2 * 10)) / (gridSize + 1)
        //      print("buttonSize = \(size)")
        return CGFloat(size)
    }
    
    private func getShipCoordinate(_ shipType: CellStatus.ShipType, shipSize: Int, shipDirection:ShipDirection, row: Int, col: Int,blockState: inout [[CellStatus]]) {
        
        showAlert = false
        
        var shipCoordinate: [(Int,Int)] = []
        if shipDirection == ShipDirection.horizontal {
            //if col + shipSize + 1 <= 10 {
            if col + shipSize - 1 <= 9 {
                for index in 0..<shipSize {
                    shipCoordinate.append((row, col + index))
                }
                print("shipCoordinate_horizontal: \(shipCoordinate)")
                
                //checkOverlapping cells
                for (row, rowBlock) in blockState.enumerated() {
                    for (col, _) in rowBlock.enumerated() {
                        for coordinate in shipCoordinate {
                            if coordinate.1 == col && coordinate.0 == row &&
                                blockState[row][col].shipType != nil && blockState[row][col].shipType != shipType {
                                showAlert = true
                                print("Invalid placement, overlapping cells, alert shows")
                                return
                            }
                        }
                    }
                }
                
                
                for (row, rowBlock) in blockState.enumerated() {
                    for (col, _) in rowBlock.enumerated() {
                        //clear current ship status if it was there
                        if blockState[row][col].shipType == shipType {
                            blockState[row][col].bgColor = .blue
                            blockState[row][col].shipType = nil
                        }
                        //update the latest ship View
                        for coordinate in shipCoordinate {
                            if coordinate.1 == col && coordinate.0 == row {
                                blockState[row][col].bgColor = .green
                                blockState[row][col].shipType = shipType
                            }
                        }
                    }
                }
            } else {
                print("This is out of the range.")
            }
        }
        if shipDirection == ShipDirection.vertical {
            // if row + shipSize + 1 <= 10 {
            if row + shipSize - 1 <= 9 {
                for index in 0..<shipSize {
                    shipCoordinate.append((row + index , col))
                }
                print("shipCoordinate_vertical: \(shipCoordinate)")
                for (row, rowBlock) in blockState.enumerated() {
                    for (col, _) in rowBlock.enumerated() {
                        //clear current ship status if it was there
                        if blockState[row][col].shipType == shipType {
                            blockState[row][col].bgColor = .blue
                            blockState[row][col].shipType = nil
                        }
                        
                        //update latest ship view
                        for coordinate in shipCoordinate {
                            if coordinate.1 == col && coordinate.0 == row {
                                blockState[row][col].bgColor = .green
                                blockState[row][col].shipType = shipType
                            }
                        }
                    }
                }
                
            } else {
                print("This is out of the range.")
                
            }
        }
    }
}


struct BoldButtonStyle: ButtonStyle {
    var isAnimating: Bool
    //var isSelectedShip: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
        //  .padding()
            .background(isAnimating ? .green : .blue)
            .cornerRadius(10)
            .scaleEffect(isAnimating ? 1.0 : 0.8)
            .animation(.spring())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      ContentView()
//    }
//}

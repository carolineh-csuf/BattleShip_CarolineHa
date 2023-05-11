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
    
   // @Binding var blockTextStruct: [[CellStatus]]
    
    @State var blockTextStruct:[[CellStatus]] = [[.init(cellType: CellStatus.CellType.empty, isSelected: false, bgColor: .blue)]]
    
    @State var selectedRow = 0
    @State var selectedCol = 0
    
    
    @State private var isAnimating: Bool = false
    @State private var isHorizontal: Bool = false
    
    var body: some View {

        VStack {
            
            Text("BattleShip")
                .font(.largeTitle)
                .foregroundColor(.black)
            
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
                                CellView(row: rowIndex, col: columnIndex, selectedRow: $selectedRow, selectedCol: $selectedCol, blockState: $blockTextStruct)
                            }
                        }
                    }
                }
                .offset(x: getButtonSize()/2 ,y: getButtonSize()/2)
                .onAppear {
                    initializeBlockTextStruct()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.secondary)
            
            Text("Your Fleet:")
                .font(.title2)
                .padding(.top)
            
            HStack() {
                Button(action: {
                    withAnimation {
                        isAnimating.toggle()
                    }
                }){
                    Text("Carrier: size 5")
                        .padding()
                }
                .buttonStyle(BoldButtonStyle(isAnimating: isAnimating))
                .padding(.trailing)
                
                Toggle(isHorizontal ? "Horizontal" : "Vertical", isOn: $isHorizontal)
                //.padding()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .frame(width: 150)
                    .onChange(of: isHorizontal) { newValue in
                        // Handle toggle state change
                        print("Toggle Horizontal direction to: \(newValue)")
                    }
            }
            
            
            Button(action: {
                //TODO:
            }){
                Text("BattleShip: size 4")
                    .padding()
            }
            //     .buttonStyle(BoldButtonStyle())
            
            Button(action: {
                //TODO:
            }){
                Text("Cruiser: size 3")
                    .padding()
            }
            //    .buttonStyle(BoldButtonStyle())
            
            Button(action: {
                
            }){
                Text("Destroyer: size 2")
                    .padding()
            }
            //       .buttonStyle(BoldButtonStyle())
            
            Button(action: {
                //TODO:
            }){
                Text("Submarine size 1")
                    .padding()
            }
            //          .buttonStyle(BoldButtonStyle())
            
            Spacer()
            
            Button(action: {
                //TODO:
            }){ Text("Start Game") }
            
        }

    }
    
    func initializeBlockTextStruct() {
            let numRows = gridSize
            let numColumns = gridSize
           
        blockTextStruct.removeAll()
        
            for _ in 0..<numRows {
                var row: [CellStatus] = []
                for _ in 0..<numColumns {
                    let cellStatus = CellStatus(cellType: .empty, isSelected: false, bgColor: .blue)
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
    
//    func createBlock(_ row: Int,_ col: Int) -> CellView {
//
//        return CellView(
//            row: row,
//            col: col,
//            selectedRow: $selectedRow,
//            selectedCol: $selectedCol,
//            blockState: $blockTextStruct
//        )
//    }
}


struct BoldButtonStyle: ButtonStyle {
    var isAnimating: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
          //  .padding()
            .background(isAnimating ? .green : .blue)
            .cornerRadius(10)
            .scaleEffect(isAnimating ? 1.2 : 1.0)
            .animation(.spring())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      ContentView()
//    }
//}

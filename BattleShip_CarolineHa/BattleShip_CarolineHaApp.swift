//
//  BattleShip_CarolineHaApp.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

@main
struct BattleShip_CarolineHaApp: App {
    let cells:[[CellStatus]] = [[]]
    var body: some Scene {
        WindowGroup {
            ContentView(blockTextStruct: .constant(cells))
        }
    }
}

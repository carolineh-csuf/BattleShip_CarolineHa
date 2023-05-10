//
//  CellStatus.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct CellStatus {
    
    enum CellType {
        case empty
        case ship
        case hit
        case miss
        
        var color: Color {
            switch self {
            case .empty:
                return .blue
            case .ship:
                return .gray
            case .hit:
                return .red
            case .miss:
                return .white
            }
        }
    }
    
    let cellType: CellType
}

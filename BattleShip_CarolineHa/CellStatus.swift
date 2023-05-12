//
//  CellStatus.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct CellStatus {
    
//    enum CellType {
//        case empty
//        case ship
//        case hit
//        case miss
//        
//        var color: Color {
//            switch self {
//            case .empty:
//                return .blue
//            case .ship:
//                return .gray
//            case .hit:
//                return .red
//            case .miss:
//                return .white
//            }
//        }
//    }
    
    enum ShipType {
        case carrier;
        case battleShip;
        case cruiser;
        case Destoyer;
        case submarine
    }
    
    
 //   let cellType: CellType
    var isSelected: Bool
    var bgColor: Color
    var shipType: ShipType?
    var cellText: String
}

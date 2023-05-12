//
//  CellStatus.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/10/23.
//

import SwiftUI

struct CellStatus {
    enum ShipType {
        case carrier;
        case battleShip;
        case cruiser;
        case Destoyer;
        case submarine
    }
    
    var isSelected: Bool
    var bgColor: Color
    var shipType: ShipType?
    var cellText: String
    var cellHiddenText: String // for opponent grid
}

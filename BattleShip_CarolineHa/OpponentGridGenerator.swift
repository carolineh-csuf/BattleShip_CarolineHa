//
//  OpponentGridGenerator.swift
//  BattleShip_CarolineHa
//
//  Created by csuftitan on 5/11/23.
//

import Foundation

class BattleshipGame {
    let gridSize = 10
    let shipLengths = [5, 4, 3, 3, 2]
    
    var shipCoordinates:[CellStatus.ShipType : [(Int,Int)]] = [:]
    {
        didSet{
       //     print("shipCoordinate: \(shipCoordinates)")
        }
    }

    private var grid = [[String]]()
    
    init() {
        resetGrid()
    }
    
    private func resetGrid() {
        grid = Array(repeating: Array(repeating: ".", count: gridSize), count: gridSize)
    }
    
    private func isValidPlacement(_ row: Int, _ col: Int, _ length: Int, _ direction: Bool) -> Bool {
        if direction {
            if col + length > gridSize {
                return false
            }
            
            for i in col..<col+length {
                if grid[row][i] != "." {
                    return false
                }
            }
        } else {
            if row + length > gridSize {
                return false
            }
            
            for i in row..<row+length {
                if grid[i][col] != "." {
                    return false
                }
            }
        }
        
        return true
    }
    
    private func placeShip(_ row: Int, _ col: Int, _ length: Int, _ direction: Bool) {
       // var shipCoordinates:[String : [(Int,Int)]] = [:]
        var coordinate : [(Int,Int)] = []
        if direction {
            for i in col..<col+length {
                grid[row][i] = "X"
            //    print("ship: length \(length): \(row) \(i)")
                coordinate.append((row,i))
            }
        } else {
            for i in row..<row+length {
                grid[i][col] = "X"
            //    print("ship: length \(length): \(i) \(col)")
                coordinate.append((i,col))
            }
        }
        
        if length == 5 {
            shipCoordinates.updateValue(coordinate, forKey: .carrier)
        } else if length == 4 {
            shipCoordinates.updateValue(coordinate, forKey: .battleShip)
        } else if length == 3 {
            if shipCoordinates.keys.contains(.submarine) {
                shipCoordinates.updateValue(coordinate, forKey: .cruiser)
            } else if shipCoordinates.keys.contains(.cruiser) {
                shipCoordinates.updateValue(coordinate, forKey: .submarine)
            } else {
                shipCoordinates.updateValue(coordinate, forKey: .cruiser)
            }
        } else if length == 2 {
            shipCoordinates.updateValue(coordinate, forKey: .Destoyer)
        }
        for coordinate in shipCoordinates {
           // print("ShipsCoordinate is \(coordinate)")
        }
    }
    
    func generateRandomGrid() {
        resetGrid()
        
        for length in shipLengths {
            var isValid = false
            var row = 0
            var col = 0
            var direction = true // true for horizontal, false for vertical
            
            while !isValid {
                row = Int.random(in: 0..<gridSize)
                col = Int.random(in: 0..<gridSize)
                direction = Bool.random()
                
                isValid = isValidPlacement(row, col, length, direction)
            }
            
            placeShip(row, col, length, direction)
        }
    }
    
    func printGrid() -> ([[String]],[CellStatus.ShipType : [(Int,Int)]]) {
        var result: [[String]] = []
        print("-----Opponnent Random Grid-----")
        for row in grid {
            var temp: [String] = []
            for cell in row {
                temp.append(cell)
                print(cell, terminator: " ")
            }
            print()
            result.append(temp)
        }
        
        return (result, shipCoordinates)
    }
}

// Usage example
//let game = BattleshipGame()
//game.generateRandomGrid()
//game.printGrid()



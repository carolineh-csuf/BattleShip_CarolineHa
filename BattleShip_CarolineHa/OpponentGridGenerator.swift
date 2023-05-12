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
        if direction {
            for i in col..<col+length {
                grid[row][i] = "X"
            }
        } else {
            for i in row..<row+length {
                grid[i][col] = "X"
            }
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
    
    func printGrid() -> [[String]] {
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
        return result
    }
}

// Usage example
//let game = BattleshipGame()
//game.generateRandomGrid()
//game.printGrid()



//
//  Line.swift
//  soundfalls
//
//  Created by Will Hodges on 10/9/21.
//

import SpriteKit

class Line {
    // Create a path
    let line = SKShapeNode()
    let path = CGMutablePath()
    
    var length: CGFloat
    
    init(start: CGPoint, end: CGPoint) {
        // Set the path from start to end
        self.path.move(to: start)
        self.path.addLine(to: end)
        self.line.path = self.path
        
        // Color
        self.line.strokeColor = SKColor.black
        self.line.lineWidth = 3
        
        self.line.name = "line"
        
        // Add physics -- make sure it collides but doesn't move
        self.line.physicsBody = SKPhysicsBody(edgeChainFrom: self.path)
        self.line.physicsBody?.isDynamic = false
        
        // And make sure it only collides with balls
        self.line.physicsBody?.categoryBitMask = Constants.lineBitMask
        self.line.physicsBody?.collisionBitMask = Constants.ballBitMask
        
        // And calculate the length
        self.length = pow(abs(start.x - end.x), 2) + pow(abs(start.y - end.y), 2).squareRoot()
    }
    
    func getLine() -> SKShapeNode {
        return self.line
    }
}

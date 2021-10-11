//
//  Ball.swift
//  soundfalls
//
//  Created by Will Hodges on 10/9/21.
//

import SpriteKit

class Ball {
    
    let size: CGFloat = 5
    
    var ball: SKShapeNode? = nil
    
    init(position: CGPoint, fill: Bool) {
        // Make the circle
        self.ball = SKShapeNode(circleOfRadius: size)
        self.ball?.position = position
        self.ball?.physicsBody = SKPhysicsBody(circleOfRadius: self.size)
        
        // Make it bouncy
        self.ball?.physicsBody?.restitution = 0.9
        
        if fill {
            // Make sure the ball only collides with lines and passes through balls
            self.ball?.physicsBody?.categoryBitMask = Constants.ballBitMask
            self.ball?.physicsBody?.collisionBitMask = Constants.lineBitMask
            
            // Make sure we know when a contact occurs
            self.ball?.physicsBody?.contactTestBitMask = Constants.lineBitMask
            
            
            // Name it so we know what it is
            self.ball?.name = "ball"
            
            // Fill the color in
            self.ball?.fillColor = SKColor.black
        } else {
            // Make sure the source block doesn't collide with anything
            self.ball?.physicsBody?.categoryBitMask = Constants.sourceBitMask
            self.ball?.physicsBody?.collisionBitMask = Constants.sourceBitMask
            
            // Make it unmoveable
            self.ball?.physicsBody?.isDynamic = false
            
            // Make it hollow
            self.ball?.strokeColor = SKColor.black
        }
    }
    
    func getBall() -> SKShapeNode {
        return self.ball!
    }
}

//
//  GameScene.swift
//  soundfalls
//
//  Created by Will Hodges on 10/9/21.
//

import SpriteKit
import AVKit

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    var path: [CGPoint] = [CGPoint]()
    
    var resetButton: SKLabelNode = SKLabelNode(text: "RESET")
    
    var source: Ball? = nil
    
    override func didMove(to view: SKView) {
        // So we can run code when things touch
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = SKColor.white
        
        // If you run one sound at the start it removes the lag
        // When the first ball hits a line
        run(Constants.c1)
        
        // Create source block
        self.source = Ball(position: CGPoint(x: view.frame.width / 2, y: view.frame.width / 2), fill: false)
        
        // Position reset button at top of screen
        self.resetButton.position = CGPoint(x: view.frame.width / 2, y: view.frame.height - (self.resetButton.frame.height * 2.5))
        self.resetButton.fontColor = SKColor.black
        self.resetButton.fontSize = 30
        
        // Have the source generate balls
        self.source!.getBall().run(
            SKAction.repeatForever(SKAction.sequence([
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.addBall()
                    },
                ])
            )
        )
        
        addChild(self.source!.getBall())
        addChild(self.resetButton)
    }
    
    func addBall() {
        let ball = Ball(position: self.source!.getBall().position, fill: true)
        addChild(ball.getBall())
        
        // Make sure if it gets stuck, it disappears
        ball.getBall().run(
            SKAction.sequence([
                SKAction.wait(forDuration: 20),
                SKAction.fadeOut(withDuration: 3),
                SKAction.removeFromParent()
            ])
        )
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.path.append(touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.path.count > 1 {
            // If we've got a long path, we need to draw a line
            let start = self.path[0]
            let end = self.path[self.path.count - 1]
            self.path = [CGPoint]()
            
            // Create a path
            let l = Line(start: start, end: end)
            
            addChild(l.getLine())
        } else {
            // If we've single clicked...
            for touch in touches {
                if self.resetButton.contains(touch.location(in: self)) {
                    // If we've touched the reset button,
                    // then we should clear the scene
                    removeAllChildren()
                    addChild(self.resetButton)
                    addChild(self.source!.getBall())
                } else {
                    let location = touch.location(in: self)
                    
                    // Otherwise, we should move the source block
                    self.source!.getBall().position = location
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let line = contact.bodyA.node?.name == "line" ? contact.bodyA : contact.bodyB
        
        // Calculations for pitch
        // Determine line size as percentage of screen
        let lineWidth = line.node?.frame.width
        let lineHeight = line.node?.frame.height
        let lineDiag = sqrt(pow(Float(lineWidth!), 2) + pow(Float(lineHeight!), 2))
        
        let frameWidth = view?.frame.width
        let frameHeight = view?.frame.height
        let frameDiag = sqrt(pow(Float(frameWidth!), 2) + pow(Float(frameHeight!), 2))
        
        let pitch = lineDiag / frameDiag
        
        if pitch <= 0.06 {
            run(Constants.c3)
        } else if pitch <= 0.12 {
            run(Constants.b2)
        } else if pitch <= 0.18 {
            run(Constants.a2)
        } else if pitch <= 0.24 {
            run(Constants.g2)
        } else if pitch <= 0.30 {
            run(Constants.f2)
        } else if pitch <= 0.36 {
            run(Constants.e2)
        } else if pitch <= 0.42 {
            run(Constants.d2)
        } else if pitch <= 0.48 {
            run(Constants.c2)
        } else if pitch <= 0.54 {
            run(Constants.b1)
        } else if pitch <= 0.60 {
            run(Constants.a1)
        } else if pitch <= 0.66 {
            run(Constants.g1)
        } else if pitch <= 0.72 {
            run(Constants.f1)
        } else if pitch <= 0.78 {
            run(Constants.e1)
        } else if pitch <= 0.84 {
            run(Constants.d1)
        } else {
            run(Constants.c1)
        }
    }
    
}

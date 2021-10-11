//
//  GameViewController.swift
//  soundfalls
//
//  Created by Will Hodges on 10/9/21.
//
import SpriteKit

class GameViewController : UIViewController {
    
    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size);
        let skView = view as! SKView
        skView.presentScene(scene);
    }
}

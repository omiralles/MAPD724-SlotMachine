// Student Name: Carlos Hernandez Galvan
// Student ID: 301290263
//
// Student Name: Oscar Miralles Fernandez
// Student ID: 301250756
//
// Student Name: Yingda Zhang
// Student ID: 301275707
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                }
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

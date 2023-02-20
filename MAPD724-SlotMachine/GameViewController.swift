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

    //View elements added
    @IBOutlet weak var HelpScrollView: UIScrollView!
    @IBOutlet weak var TopWinLabel: UILabel!
    @IBOutlet weak var AwardsScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HelpScrollView.isHidden = true
        AwardsScrollView.isHidden = true
        GameScene.gameViewController = self
        
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
    
    //Show help ScrollView
    func showHelp() {
        HelpScrollView.isHidden = false
    }
    
    //Show top socre ScrollView
    func showAwards() {
        let loadData = UserDefaults.standard
        let topWin = loadData.integer(forKey: "topwin")
        //Wite the top score in the label
        TopWinLabel.text = "TOP USER WINNIGS: $ \(topWin)"
        
        AwardsScrollView.isHidden = false
    }
    
    //Hide Help ScrollView
    @IBAction func CloseHelpButton(_ sender: Any) {
        HelpScrollView.isHidden = true
    }
    
    //Hide Top Score ScrollView
    @IBAction func CloseAwardButton(_ sender: Any) {
        AwardsScrollView.isHidden = true
    }
}

// Student Name: Carlos Hernandez Galvan
// Student ID: 301290263
//
// Student Name: Oscar Miralles Fernandez
// Student ID: 301250756
//
// Student Name: Yingda Zhang
// Student ID: 301275707
//

import SpriteKit
import GameplayKit

class LabelJackPot : GameObject {
    // constructor or initializer
    init () {
        super.init(imageString: "jackpot", initialScale: 0.9)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder: ) has not been initialized")
    }
    
    override func Start() {
        zPosition = Layer.symbol.rawValue
    }
    
    override func Update() {
        
    }
    
    override func CheckBounds() {
        
    }
    
    override func Reset() {
        
    }
    
    func Move () {
        
    }
}

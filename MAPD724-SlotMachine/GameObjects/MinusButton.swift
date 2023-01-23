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

class MinusButton : GameObject {
    // constructor or initializer
    init () {
        super.init(imageString: "minus", initialScale: 1.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder: ) has not been initialized")
    }
    
    override func Start() {
        zPosition = 3
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

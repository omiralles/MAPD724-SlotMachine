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

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

class GameScene: SKScene {
    
    // get a reference to the GameViewController
    public static var gameViewController : GameViewController?
    
    //Bakcground Image
    var backgroud: BackGround?
    
    //Lables
    var lblbackgroundB: LabelBackGround?
    var lblbackgroundC: LabelBackGround?
    var lblbackgroundW: LabelBackGround?
    var lblbackgroundJ: LabelBackGround?
    var lblwinning: LabelWinnings?
    var lblcredit: LabelCredit?
    var lblbet: LabelBet?
    var lbltitle: LabelTitle?
    var lbljackpot: LabelJackPot?
    
    //Buttons
    var spinbtn: SpinButton?
    var resetbtn: ResetButton?
    var exitbtn: ExitButton?
    var helpbtn: HelpButton?
    var awardbtn: AwardButton?
    var plusbtn: PlusButton?
    var minusbtn: MinusButton?
    var spindisablebtn: SpinDisableButton?
    
    //Variable for matrix animation
    var matrixAnimation = SKSpriteNode()
    var matrixAnimFrames: [SKTexture] = []
    
    //Variables for symbols animation
    var symbolAnimation1 = SKSpriteNode()
    var symbolAnimation2 = SKSpriteNode()
    var symbolAnimation3 = SKSpriteNode()
    var symbolAnimationFrames: [SKTexture] = []
    
    //Scales animate symbols
    var scaleVal1: CGFloat = 0.0
    var scaleVal2: CGFloat = 0.0
    var scaleVal3: CGFloat = 0.0
    
    //Lables
    var creditLabel: SKLabelNode!
    var betLabel: SKLabelNode!
    var winLabel: SKLabelNode!
    var jackPotLabel: SKLabelNode!
    
    //Init score and symbols management
    var scoreMngt = ScoresManager()
    
    //Create components and inicialize them
    override func sceneDidLoad() {
        screenWidth = frame.width
        screenHeight = frame.height
        
        name = "Matrix Slot Machine"
        
        backgroud = BackGround()
        addChild(backgroud!)
        
        spinbtn = SpinButton()
        spinbtn?.name = "spin"
        addChild(spinbtn!)
        
        spindisablebtn = SpinDisableButton()
        spindisablebtn?.name = "spindisable"
        addChild(spindisablebtn!)
        
        resetbtn = ResetButton()
        resetbtn?.name = "reset"
        addChild(resetbtn!)
        
        exitbtn = ExitButton()
        exitbtn?.name = "exit"
        addChild(exitbtn!)
        
        helpbtn = HelpButton()
        helpbtn?.name = "help"
        addChild(helpbtn!)
        
        awardbtn = AwardButton()
        awardbtn?.name = "awards"
        addChild(awardbtn!)
        
        lblbackgroundW = LabelBackGround()
        lblbackgroundW?.position = CGPoint(x: -37, y: 289)
        addChild(lblbackgroundW!)
        
        lblbackgroundC = LabelBackGround()
        lblbackgroundC?.position = CGPoint(x: 110, y: 289)
        addChild(lblbackgroundC!)
        
        lblbackgroundB = LabelBackGround()
        lblbackgroundB?.position = CGPoint(x: -9, y: -205)
        lblbackgroundB?.setScale(1.0)
        addChild(lblbackgroundB!)
        
        lblbackgroundJ = LabelBackGround()
        lblbackgroundJ?.position = CGPoint(x: 98, y: 325)
        addChild(lblbackgroundJ!)
        
        lblwinning = LabelWinnings()
        lblwinning?.position = CGPoint(x: -120, y: 290)
        addChild(lblwinning!)
        
        lblcredit = LabelCredit()
        lblcredit?.position = CGPoint(x: 40, y: 289)
        addChild(lblcredit!)
        
        lblbet = LabelBet()
        lblbet?.position = CGPoint(x: -110, y: -205)
        addChild(lblbet!)
        
        plusbtn = PlusButton()
        plusbtn?.position = CGPoint(x: 75, y: -204)
        plusbtn?.name = "plus"
        addChild(plusbtn!)
        
        minusbtn = MinusButton()
        minusbtn?.position = CGPoint(x: 122, y: -204)
        minusbtn?.name = "minus"
        addChild(minusbtn!)
        
        creditLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        creditLabel.name = "creditlbl"
        creditLabel.fontColor = UIColor.green
        creditLabel.fontSize = 16
        creditLabel.position = CGPoint(x: 105, y: 285)
        creditLabel.zPosition = Layer.label.rawValue
        addChild(creditLabel)
        
        betLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        betLabel.name = "betlbl"
        betLabel.fontColor = UIColor.green
        betLabel.fontSize = 16
        betLabel.position = CGPoint(x: -45, y: -208)
        betLabel.zPosition = Layer.label.rawValue
        addChild(betLabel)
        
        winLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        winLabel.name = "winlbl"
        winLabel.fontColor = UIColor.green
        winLabel.fontSize = 16
        winLabel.position = CGPoint(x: -40, y: 285)
        winLabel.zPosition = Layer.label.rawValue
        addChild(winLabel)
        
        jackPotLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        jackPotLabel.name = "jackpotlbl"
        jackPotLabel.fontColor = UIColor.green
        jackPotLabel.fontSize = 16
        jackPotLabel.position = CGPoint(x: 95, y: 320)
        jackPotLabel.zPosition = Layer.label.rawValue
        addChild(jackPotLabel)
        
        lbltitle = LabelTitle()
        lbltitle?.position = CGPoint(x: -75, y: 330)
        addChild(lbltitle!)
        
        lbljackpot = LabelJackPot()
        lbljackpot?.position = CGPoint(x: 100, y: 330)
        addChild(lbljackpot!)
        
        //Create animations
        buildMatrix()
        buildSymbols()
        
        //Initialize results
        scoreMngt.resetResults()
        
        //Update app labels
        updateLabels()
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    func buildMatrix() {
        //Load images to create matrix letters animation
        let matrixAnimatedAtlas = SKTextureAtlas(named: "MatrixCodes")
        var matrixFrames: [SKTexture] = []

        let numImages = matrixAnimatedAtlas.textureNames.count
        
        for i in 1...numImages {
            let matrixTextureName = "MatrixCode\(i)"
            matrixFrames.append(matrixAnimatedAtlas.textureNamed(matrixTextureName))
        }
        matrixAnimFrames = matrixFrames
        
        let firstFrameTexture = matrixAnimFrames[0]
        
        matrixAnimation = SKSpriteNode(texture: firstFrameTexture)
        matrixAnimation.position = CGPoint(x: frame.midX, y: 120)
        matrixAnimation.xScale = 0.5
        matrixAnimation.yScale = 0.5
        matrixAnimation.zPosition = Layer.matrix.rawValue
        
        addChild(matrixAnimation)
        animateMatrix()
    }

    func animateMatrix() {
        //Run de animation during all execution
        matrixAnimation.run(SKAction.repeatForever(
            SKAction.animate(with: matrixAnimFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: false)),
                            withKey:"matrixAnimationCode")
    }

    func buildSymbols() {
        //Load symbols imatges
        let symbolAnimatedAtlas = SKTextureAtlas(named: "Symbols")
        var symbolFrames: [SKTexture] = []
        
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("blank"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("grapes"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("banana"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("orange"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("cherry"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("bar"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("bell"))
        symbolFrames.append(symbolAnimatedAtlas.textureNamed("seven"))
        symbolAnimationFrames = symbolFrames
        
        //Load a random image
        var rnd: Int = scoreMngt.runTheRheels()
        var firstFrameTexture = symbolAnimationFrames[rnd]
        
        symbolAnimation1 = SKSpriteNode(texture: firstFrameTexture)
        symbolAnimation1.position = CGPoint(x: -90, y: 100)
        symbolAnimation1.xScale = 0.0
        symbolAnimation1.yScale = 0.0
        symbolAnimation1.zPosition = Layer.symbol.rawValue
        addChild(symbolAnimation1)
        
        //Load a random image
        rnd = scoreMngt.runTheRheels()
        firstFrameTexture = symbolAnimationFrames[rnd]
        
        symbolAnimation2 = SKSpriteNode(texture: firstFrameTexture)
        symbolAnimation2.position = CGPoint(x: -25, y: 100)
        symbolAnimation2.xScale = 0.0
        symbolAnimation2.yScale = 0.0
        symbolAnimation2.zPosition = Layer.symbol.rawValue
        addChild(symbolAnimation2)
        
        //Load a random image
        rnd = scoreMngt.runTheRheels()
        firstFrameTexture = symbolAnimationFrames[rnd]
        
        symbolAnimation3 = SKSpriteNode(texture: firstFrameTexture)
        symbolAnimation3.position = CGPoint(x: 35, y: 100)
        symbolAnimation3.xScale = 0.0
        symbolAnimation3.yScale = 0.0
        symbolAnimation3.zPosition = Layer.symbol.rawValue
        addChild(symbolAnimation3)
        
        //animateSymbols()
        if (scoreMngt.determineResult()) {
            let alert = UIAlertController(title: "Congratulations! You WIN!!", message: "You have win de JackPot", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        //print("Touch Down")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //print("Touch Moved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //print("Touch Up")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Touch detection for the actions
        for t in touches {
            let location = t.location(in: self)
            let touchNode = atPoint(location)
            
            //Spin action when symblos animations are finished
            if ((touchNode.name == "spin") && completeScale()) {
                //Alert in case bet is 0
                if (scoreMngt.scores.playerBet == 0) {
                    let alert = UIAlertController(title: "Can't place $0 bet", message: "Please choose amount to bet.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                //Alert if credit is exceeded in the bed
                else if ((scoreMngt.scores.playerBet > scoreMngt.scores.currentCredit) && (scoreMngt.scores.currentCredit > 0)) {
                    let alert = UIAlertController(title: "Credit Exceeded", message: "You don't have enough credit. Decrease your bet", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                //Alert if you don't have credit
                else if (scoreMngt.scores.currentCredit == 0) {
                    let alert = UIAlertController(title: "No credit", message: "You don't have credit. Push reset to start again", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                //Spin new symbols
                else {
                    //Remove symbols
                    symbolAnimation1.removeAllChildren()
                    symbolAnimation2.removeAllChildren()
                    symbolAnimation3.removeAllChildren()
                    
                    symbolAnimation1.removeFromParent()
                    symbolAnimation2.removeFromParent()
                    symbolAnimation3.removeFromParent()
                    
                    //Inicialize scales
                    scaleVal1 = 0.0
                    scaleVal2 = 0.0
                    scaleVal3 = 0.0
                    
                    //Reset symbols
                    scoreMngt.resetFruitTally()
                    buildSymbols()
                }
            }
            if ((touchNode.name == "spindisable") && completeScale()) {
                let alert = UIAlertController(title: "Credit Exceeded", message: "You don't have enough credit. Decrease your bet", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            //Action exit button
            if (touchNode.name == "exit") {
                exit(0)
            }
            //Increment bet
            if (touchNode.name == "plus"){
                if ((scoreMngt.scores.playerBet + 10) <= scoreMngt.scores.currentCredit) {
                    scoreMngt.scores.playerBet += 10
                }
            }
            //Decrement bet
            if (touchNode.name == "minus"){
                if ((scoreMngt.scores.playerBet - 10) >= 0) {
                    scoreMngt.scores.playerBet -= 10
                }
            }
            //Button awards pressed
            if (touchNode.name == "awards"){
                GameScene.gameViewController?.showAwards()
            }
            //Button help pressed
            if (touchNode.name == "help"){
                GameScene.gameViewController?.showHelp()
            }
            //Reset all the values and components
            if (touchNode.name == "reset") {
                //Reset results
                scoreMngt.resetResults()
                
                //Remove symbols
                symbolAnimation1.removeAllChildren()
                symbolAnimation2.removeAllChildren()
                symbolAnimation3.removeAllChildren()
                
                symbolAnimation1.removeFromParent()
                symbolAnimation2.removeFromParent()
                symbolAnimation3.removeFromParent()
                
                //Inicialize scales
                scaleVal1 = 0.0
                scaleVal2 = 0.0
                scaleVal3 = 0.0
                
                //Reset symbols
                scoreMngt.resetFruitTally()
                buildSymbols()
            }
            //Update all the application labels
            updateLabels()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //Change the scale to create animation with symbols
        if (scaleVal1 <= 0.8){
            scaleVal1 += 0.01
            symbolAnimation1.setScale(scaleVal1)
        }
        else if (scaleVal2 <= 0.8){
            scaleVal2 += 0.01
            symbolAnimation2.setScale(scaleVal2)
        }
        else if (scaleVal3 <= 0.8){
            scaleVal3 += 0.01
            symbolAnimation3.setScale(scaleVal3)
        }
        //Show disable button image if not enough credit
        if (scoreMngt.scores.playerBet > scoreMngt.scores.currentCredit) {
            spindisablebtn?.zPosition = 4
        }
        else {
            spindisablebtn?.zPosition = 0
        }
    }
    
    //Check if symbols are fully displayed
    func completeScale() -> Bool {
        if (scaleVal1 > 0.8 && scaleVal2 > 0.8 && scaleVal3 > 0.8) {
            return true
        }
        return false
    }
    
    //Update numeric labels
    func updateLabels() {
        creditLabel.text = "$ \(scoreMngt.scores.currentCredit)"
        betLabel.text = "$ \(scoreMngt.scores.playerBet)"
        winLabel.text = "$ \(scoreMngt.scores.currentWinnings)"
        jackPotLabel.text = "$ \(scoreMngt.scores.currentJackPot)"
        
    }
}

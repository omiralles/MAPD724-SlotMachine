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
    
    //Bet, credit and result
    var initCredit: Int = 1000
    var currentCredit: Int = 0
    var playerBet: Int = 0
    //public var playResult: Bool = false
    var prize: Int = 0
    var currentWinnings: Int = 0
    var currentJackPot: Int = 5000
    
    //Simbols number
    var grapes = 0;
    var bananas = 0;
    var oranges = 0;
    var cherries = 0;
    var bars = 0;
    var bells = 0;
    var sevens = 0;
    var blanks = 0;
    
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
        currentCredit = initCredit
        //creditLabel.text = "$ \(currentCredit)"
        creditLabel.fontColor = UIColor.green
        creditLabel.fontSize = 16
        creditLabel.position = CGPoint(x: 105, y: 285)
        creditLabel.zPosition = 4
        addChild(creditLabel)
        
        betLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        betLabel.name = "betlbl"
        //betLabel.text = "$ \(playerBet)"
        betLabel.fontColor = UIColor.green
        betLabel.fontSize = 16
        betLabel.position = CGPoint(x: -45, y: -208)
        betLabel.zPosition = 4
        addChild(betLabel)
        
        winLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        winLabel.name = "winlbl"
        //winLabel.text = "$ \(prize)"
        winLabel.fontColor = UIColor.green
        winLabel.fontSize = 16
        winLabel.position = CGPoint(x: -40, y: 285)
        winLabel.zPosition = 4
        addChild(winLabel)
        
        jackPotLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Bold")
        jackPotLabel.name = "jackpotlbl"
        //jackPotLabel.text = "$ \(currentJackPot)"
        jackPotLabel.fontColor = UIColor.green
        jackPotLabel.fontSize = 16
        jackPotLabel.position = CGPoint(x: 95, y: 320)
        jackPotLabel.zPosition = 4
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
        
        currentWinnings = 0
        
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
        matrixAnimation.zPosition = 0
        
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
        var rnd: Int = runTheRheels()
        var firstFrameTexture = symbolAnimationFrames[rnd]
        
        symbolAnimation1 = SKSpriteNode(texture: firstFrameTexture)
        symbolAnimation1.position = CGPoint(x: -90, y: 100)
        symbolAnimation1.xScale = 0.0
        symbolAnimation1.yScale = 0.0
        symbolAnimation1.zPosition = 1
        addChild(symbolAnimation1)
        
        //Load a random image
        rnd = runTheRheels()
        firstFrameTexture = symbolAnimationFrames[rnd]
        
        symbolAnimation2 = SKSpriteNode(texture: firstFrameTexture)
        symbolAnimation2.position = CGPoint(x: -25, y: 100)
        symbolAnimation2.xScale = 0.0
        symbolAnimation2.yScale = 0.0
        symbolAnimation2.zPosition = 1
        addChild(symbolAnimation2)
        
        //Load a random image
        rnd = runTheRheels()
        firstFrameTexture = symbolAnimationFrames[rnd]
        
        symbolAnimation3 = SKSpriteNode(texture: firstFrameTexture)
        symbolAnimation3.position = CGPoint(x: 35, y: 100)
        symbolAnimation3.xScale = 0.0
        symbolAnimation3.yScale = 0.0
        symbolAnimation3.zPosition = 1
        addChild(symbolAnimation3)
        
        //animateSymbols()
        determineResult()
    }

    func animateSymbols() {
        /*symbolAnimation1.run(SKAction.repeat(
            SKAction.animate(with: symbolAnimationFrames,
                             timePerFrame: 0.2,
                             resize: true,
                             restore: false), count: 5),
                            withKey:"symbolAnimation1")
        
        symbolAnimation2.run(SKAction.repeat(
            SKAction.animate(with: symbolAnimationFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: false), count: 5),
                            withKey:"symbolAnimation2")
        
        symbolAnimation3.run(SKAction.repeat(
            SKAction.animate(with: symbolAnimationFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: false), count: 5),
                            withKey:"symbolAnimation3")*/
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
            //self.touchDown(atPoint: t.location(in: self))
            let location = t.location(in: self)
            let touchNode = atPoint(location)
            
            //Spin action when symblos animations are finished
            if ((touchNode.name == "spin") && completeScale()) {
                //Alert in case bet is 0
                if (playerBet == 0) {
                    let alert = UIAlertController(title: "Can't place $0 bet", message: "Please choose amount to bet.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                //Alert if credit is exceeded in the bed
                else if ((playerBet > currentCredit) && (currentCredit > 0)) {
                    let alert = UIAlertController(title: "Credit Exceeded", message: "You don't have enough credit. Decrease your bet", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                //Alert if you don't have credit
                else if (currentCredit == 0) {
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
                    
                    resetFruitTally()
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
                if ((playerBet + 10) <= currentCredit) {
                    playerBet += 10
                }
            }
            //Decrement bet
            if (touchNode.name == "minus"){
                if ((playerBet - 10) >= 0) {
                    playerBet -= 10
                }
            }
            //Reset all the values and components
            if (touchNode.name == "reset") {
                currentCredit = initCredit
                playerBet = 0
                currentWinnings = 0
                currentJackPot = 5000
                
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
                
                resetFruitTally()
                buildSymbols()
                currentWinnings = 0
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
        if (playerBet > currentCredit) {
            spindisablebtn?.zPosition = 4
        }
        else {
            spindisablebtn?.zPosition = 0
        }
    }
    
    //Logic to show symbols
    func runTheRheels() -> Int {
        var resultNumber: [Int] = []
        
        let actualRandomNumber = Int.random(in: 1...65)
        resultNumber.append(actualRandomNumber)
        switch actualRandomNumber {
        case 1...27:
            blanks += 1
            return 0
        case 28...37:
            grapes += 1
            return 1
        case 38...46:
            bananas += 1
            return 2
        case 47...54:
            oranges += 1
            return 3
        case 55...59:
            cherries += 1
            return 4
        case 60...62:
            bars += 1
            return 5
        case 63...64:
            bells += 1
            return 6
        case 65:
            sevens += 1
            return 7
        default:
            return -1
        }
    }
    
    //Determinate if it's a winner combination
    private func determineResult(){
        if (blanks == 0)
        {
            if (grapes == 3) {
                prize = playerBet * 10;
            }
            else if(bananas == 3) {
                prize = playerBet * 20;
            }
            else if (oranges == 3) {
                prize = playerBet * 30;
            }
            else if (cherries == 3) {
                prize = playerBet * 40;
            }
            else if (bars == 3) {
                prize = playerBet * 50;
            }
            else if (bells == 3) {
                prize = playerBet * 75;
            }
            else if (sevens == 3) {
                prize = playerBet * 100;
            }
            else if (grapes == 2) {
                prize = playerBet * 2;
            }
            else if (bananas == 2) {
                prize = playerBet * 2;
            }
            else if (oranges == 2) {
                prize = playerBet * 3;
            }
            else if (cherries == 2) {
                prize = playerBet * 4;
            }
            else if (bars == 2) {
                prize = playerBet * 5;
            }
            else if (bells == 2) {
                prize = playerBet * 10;
            }
            else if (sevens == 2) {
                prize = playerBet * 20;
            }
            else if (sevens == 1) {
                prize = playerBet * 5;
            }
            else {
                prize = playerBet * 1;
            }
            //Check if you have won the jackpot
            checkJackPot()
            //Numer of winning spins
            currentWinnings += 1
            currentCredit += prize
        } else {
            prize = 0
            currentCredit -= playerBet
        }
        //Update labels
        updateLabels()
    }
    
    //Reset symbols results
    func resetFruitTally() {
        grapes = 0;
        bananas = 0;
        oranges = 0;
        cherries = 0;
        bars = 0;
        bells = 0;
        sevens = 0;
        blanks = 0;
    }
    
    //Check if symbols are fully displayed
    func completeScale() -> Bool {
        if (scaleVal1 > 0.8 && scaleVal2 > 0.8 && scaleVal3 > 0.8) {
            return true
        }
        return false
    }
    
    //Check if user have won jackpot whith two random numbers
    func checkJackPot() {
        let jackPotTry = Int.random(in: 1...51) + 1
        let jackPotWin = Int.random(in: 1...51) + 1
        //let jackPotTry = 1
        //let jackPotWin = 1
        
        if (jackPotTry == jackPotWin) {
            let alert = UIAlertController(title: "Congratulations! You WIN!!", message: "You have win de JackPot", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            currentCredit += currentJackPot
            currentJackPot = 1000
        }
    }
    
    //Update numeric labels
    func updateLabels() {
        creditLabel.text = "$ \(currentCredit)"
        betLabel.text = "$ \(playerBet)"
        winLabel.text = String(currentWinnings)
        jackPotLabel.text = "$ \(currentJackPot)"
        
    }
}

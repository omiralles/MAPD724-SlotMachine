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

class ScoresManager {
    var scores: Scores
    var topWinings: Int
    
    //Inicialize values. Retrieve Jackpot and Top Winings
    init(){
        let loadData = UserDefaults.standard
        let previousJackpot = loadData.integer(forKey: "jackpot")
        topWinings = loadData.integer(forKey: "topwin")
        scores = Scores(initCredit: 1000,currentCredit: 0,playerBet: 0,prize: 0,currentWinnings: 0,currentJackPot: previousJackpot,
            grapes: 0,bananas: 0,oranges: 0,cherries: 0,bars: 0,bells: 0,sevens: 0,blanks: 0)
    }
    
    //Logic to show symbols
    func runTheRheels() -> Int {
        var resultNumber: [Int] = []
        
        let actualRandomNumber = Int.random(in: 1...65)
        resultNumber.append(actualRandomNumber)
        switch actualRandomNumber {
        case 1...27:
            scores.blanks += 1
            return 0
        case 28...37:
            scores.grapes += 1
            return 1
        case 38...46:
            scores.bananas += 1
            return 2
        case 47...54:
            scores.oranges += 1
            return 3
        case 55...59:
            scores.cherries += 1
            return 4
        case 60...62:
            scores.bars += 1
            return 5
        case 63...64:
            scores.bells += 1
            return 6
        case 65:
            scores.sevens += 1
            return 7
        default:
            return -1
        }
    }
    
    //Determinate if it's a winner combination
    func determineResult() -> Bool {
        var jackpot: Bool = false
        
        if (scores.blanks == 0)
        {
            if (scores.grapes == 3) {
                scores.prize = scores.playerBet * 10;
            }
            else if(scores.bananas == 3) {
                scores.prize = scores.playerBet * 20;
            }
            else if (scores.oranges == 3) {
                scores.prize = scores.playerBet * 30;
            }
            else if (scores.cherries == 3) {
                scores.prize = scores.playerBet * 40;
            }
            else if (scores.bars == 3) {
                scores.prize = scores.playerBet * 50;
            }
            else if (scores.bells == 3) {
                scores.prize = scores.playerBet * 75;
            }
            else if (scores.sevens == 3) {
                scores.prize = scores.playerBet * 100;
            }
            else if (scores.grapes == 2) {
                scores.prize = scores.playerBet * 2;
            }
            else if (scores.bananas == 2) {
                scores.prize = scores.playerBet * 2;
            }
            else if (scores.oranges == 2) {
                scores.prize = scores.playerBet * 3;
            }
            else if (scores.cherries == 2) {
                scores.prize = scores.playerBet * 4;
            }
            else if (scores.bars == 2) {
                scores.prize = scores.playerBet * 5;
            }
            else if (scores.bells == 2) {
                scores.prize = scores.playerBet * 10;
            }
            else if (scores.sevens == 2) {
                scores.prize = scores.playerBet * 20;
            }
            else if (scores.sevens == 1) {
                scores.prize = scores.playerBet * 5;
            }
            else {
                scores.prize = scores.playerBet * 1;
            }
            //Check if you have won the jackpot
            jackpot = checkJackPot()
            //Add winnigs
            scores.currentWinnings += scores.prize
            // If winnings are bigger than the top, save value
            if (scores.currentWinnings > topWinings) {
                saveTopWins()
            }
            scores.currentCredit += scores.prize
        } else {
            scores.prize = 0
            scores.currentCredit -= scores.playerBet
            //Add jackpot and save
            scores.currentJackPot += scores.playerBet / 10
            saveJackpot()
        }
        return jackpot
    }
    
    //Check if user have won jackpot whith two random numbers
    func checkJackPot() -> Bool {
        let jackPotTry = Int.random(in: 1...11) + 1
        let jackPotWin = Int.random(in: 1...11) + 1
        
        if (jackPotTry == jackPotWin) {
            scores.currentCredit += scores.currentJackPot
            scores.currentWinnings += scores.currentJackPot
            scores.currentJackPot = 0
            if (scores.currentWinnings > topWinings) {
                saveTopWins()
            }
            saveJackpot()
            return true
        }
        return false
    }
    
    //Save actual jackpot
    func saveJackpot() {
        let saveData = UserDefaults.standard
        saveData.set(scores.currentJackPot, forKey: "jackpot")
        saveData.synchronize()
    }
    
    //Save top winnings
    func saveTopWins() {
        let saveData = UserDefaults.standard
        saveData.set(scores.currentWinnings, forKey: "topwin")
        saveData.synchronize()
    }
    
    //Reset symbols results
    func resetFruitTally() {
        scores.grapes = 0
        scores.bananas = 0
        scores.oranges = 0
        scores.cherries = 0
        scores.bars = 0
        scores.bells = 0
        scores.sevens = 0
        scores.blanks = 0
    }
    
    func resetResults() {
        scores.currentCredit = scores.initCredit
        scores.playerBet = 0
        scores.currentWinnings = 0
    }
}

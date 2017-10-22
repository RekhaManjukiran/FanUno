//
//  ViewController.swift
//  FanUno
//
//  Created by Rekha Manju Kiran on 17/10/2017.
//  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
//

import UIKit
import SDWebImage
import Koloda

class HomeViewController: UIViewController, KolodaViewDataSource,KolodaViewDelegate {
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var fppgScoreLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var decisionLabel: UILabel!
    
    @IBOutlet weak var swipeCardView: KolodaView!
    weak var currentCard : PlayersCardView!
    
    var network = Network()
    var playersArray = [Player]()
    var combination = [[Int]]()
    var leftDestArray = [Player]()
    var rightDestArray = [Player]()
    var rightPlayerFppg: Double = 0.0
    var leftPlayerFppg: Double = 0.0
    var playerScore = 0
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeCardView.dataSource = self
        swipeCardView.delegate = self
        
        network.retrievePlayersJSON(completionHandler: { success, player in
            guard let playerItem = player else { return }
            if success {
                self.playersArray = playerItem
                self.generateRandomPlayerCombinations()
                //                self.selectRandomPlayer()
            }
        })
        fppgScoreLabel.text = "0"
        playerScoreLabel.text = "Score:  \(playerScore)"
        
        self.leftTitleLabel.isHidden = true
        self.rightTitleLabel.isHidden = true
        self.decisionLabel.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateRandomPlayerCombinations() {
        var indexArray = [Int]()
        var index: Int = 0;
        while index < self.playersArray.count {
            indexArray.append(index)
            index += 1
        }
        var orderedCollection = self.generateNonRepeatingComination(array: indexArray, k: 2)
        // randomise collection
        var randomIndex = 0 ;
        while randomIndex < orderedCollection.count{
            randomIndex = Int(arc4random_uniform(UInt32(orderedCollection.count)))
            self.combination.append(orderedCollection[randomIndex])
            orderedCollection.remove(at: randomIndex)
            randomIndex = 0 // This will run until all objects in orderedCollection are removed
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.playerScore = 0;
            self.swipeCardView.resetCurrentCardIndex()
            self.swipeCardView.reloadData()
        }
        
        
    }
    
    func generateNonRepeatingComination(array: [Int], k: Int) -> [[Int]] {
        // -> Array<Array<Int>>
        var variableArray = array
        if k == 0 {
            return [[]]
        }
        
        if array.isEmpty {
            return []
        }
        
        let head = array[0]
        
        var combinations = [[Int]]()
        let subCombinations: [Array<Int>] = generateNonRepeatingComination(array:variableArray, k: k-1)    // error: '(@Ivalue [Int], $T5) -> $T6' is not identical to '[NSArray]'
        for subcombo in subCombinations {
            var sub = subcombo
            if sub.first != head {
                sub.insert(head, at: 0)
                combinations.append(sub)
            }
        }
        variableArray.remove(at:0)
        combinations += generateNonRepeatingComination(array: variableArray, k: k)
        // error: '(@Ivalue [Int], Int) -> $T5' is not identical to '[NSArray]'
        
        return combinations
    }
    
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return self.combination.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .slow
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let view = Bundle.main.loadNibNamed("PlayersCardView", owner: self, options: nil)?.first
        let cardView = view as! PlayersCardView
        let combination = self.combination[index]
        if let leftPlayerIndex = combination.first, let rightPlayerIndex = combination.last {
            cardView.leftPlayer = self.playersArray[leftPlayerIndex]
            cardView.rightPlayer = self.playersArray[rightPlayerIndex]
            cardView.configureViewWith(leftPlayer: self.playersArray[leftPlayerIndex],
                                       rightPlayer: self.playersArray[rightPlayerIndex])
        }
        
        return cardView
    }
    
    
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection){
        let currentCardView:PlayersCardView = koloda.viewForCard(at: koloda.currentCardIndex) as! PlayersCardView
        currentCardView.updateViewProportions(factor: finishPercentage/100, choice: direction)
    }
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int){
        print(index)
    }
    
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){
        self.playerChosen(direction: direction, combinationIndex: index)
    }
    
    func playerChosen(direction: SwipeResultDirection, combinationIndex: Int) {
        if let leftPlayerIndex = self.combination[combinationIndex].first,
            let rightPlayerIndex = self.combination[combinationIndex].last {
            
            let leftPlayer = self.playersArray[leftPlayerIndex]
            let rightPlayer = self.playersArray[rightPlayerIndex]
            
            self.leftTitleLabel.text = leftPlayer.firstName + "\n" + "\(leftPlayer.fppg)"
            self.rightTitleLabel.text = rightPlayer.firstName + "\n" + "\(rightPlayer.fppg)"
            
            self.leftTitleLabel.isHidden = false
            self.rightTitleLabel.isHidden = false
            self.decisionLabel.isHidden = false
            
            if ((direction == .left && (rightPlayer.fppg > leftPlayer.fppg))
                || (direction == .right && (rightPlayer.fppg < leftPlayer.fppg))) {
                self.updateScoreLabel()
                decisionLabel.text = "Correct!"
                UIView.animate(withDuration: 3.0, animations: {
                    self.playerScoreLabel.font =  self.playerScoreLabel.font.withSize(self.playerScoreLabel.font.pointSize+2)
                }, completion: { (success) in
                    self.playerScoreLabel.font =  self.playerScoreLabel.font.withSize(self.playerScoreLabel.font.pointSize-2)
                })
            } else {
                //Incorrect
                decisionLabel.text = "Try Again!"
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
                self.leftTitleLabel.isHidden = true
                self.rightTitleLabel.isHidden = true
                self.decisionLabel.isHidden = true
                self.leftTitleLabel.text = ""
                self.rightTitleLabel.text = ""
                self.decisionLabel.text = ""
            }
            
        }
    }
    
    
    @IBAction func leftPlayerSelected(_ sender: Any) {
        self.swipeCardView.swipe(.left)
    }
    
    @IBAction func rightPlayerSelected(_ sender: Any) {
        self.swipeCardView.swipe(.right)
    }
    
    func updateScoreLabel() {
        playerScore += 1
        playerScoreLabel.text = "Score: \(playerScore)  ||  Attempts :  \(self.swipeCardView.currentCardIndex)"
        if(playerScore == 10)
        {
            var alert = UIAlertController.init(title: "Congratulations", message: "You have achieved 10 correct guesses. Lets see if you can better your performance the next time", preferredStyle: UIAlertControllerStyle.alert)
            var alertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                self.generateRandomPlayerCombinations()
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


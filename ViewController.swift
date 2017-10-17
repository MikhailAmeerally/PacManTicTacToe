//
//  ViewController.swift
//  PacManTicTacToe
//
//  Created by Mikhail Ameerally on 2017-10-15.
//  Copyright © 2017 Mikhail Ameerally. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var player1Turn = true;
    var gameState = [0,0,0,0,0,0,0,0,0]
    var pacmanScoreInt = 0;
    var ghostScoreInt = 0;
    let gameWinsHorizontal = [[0,1,2], [3,4,5], [6,7,8]]
    let gameWinsVertical = [[0,3,6], [1,4,7], [2,5,8]]
    let gameWinsDiagonal = [[0,4,8], [2,4,6]]
    
    
    @IBOutlet weak var pacmanScore: UILabel!
    @IBOutlet weak var GhostScore: UILabel!
    
    
    
    
    
    
    
    @IBAction func player_button(_ sender: UIButton)
    {
        
        //Set Button Image and Update Game State
        if (player1Turn)
        {
            sender.setImage(UIImage(named:"pacman.png"), for: UIControlState())
            player1Turn = false;
            gameState[sender.tag-1] = 1
            if(isWinner(winner: 1))
            {
                gameOver(winner: 1)
            }
            
            
        }
        else
        {
            choose_ghost(ghost: Int(arc4random_uniform(3)), sender: sender)
            player1Turn = true;
            gameState[sender.tag-1] = 2
            if(isWinner(winner: 2))
            {
                gameOver(winner: 2)
            }
        }
        
        //Disable Button
        sender.isUserInteractionEnabled = false
        
        
        
        
        // Check Draw
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func choose_ghost(ghost:Int, sender: UIButton) -> Void
    {
        if(ghost == 0)
        {
            sender.setImage(UIImage(named:"ghost_red.png"), for: UIControlState())
        }
        if(ghost == 1)
        {
            sender.setImage(UIImage(named:"ghost_orange.png"), for: UIControlState())
        }
        if(ghost == 2)
        {
            sender.setImage(UIImage(named:"ghost_pink.png"), for: UIControlState())
        }
    }
    
    func isWinner(winner: Int) -> Bool
    {
        for possibleWin in gameWinsHorizontal
        {
            if(gameState[possibleWin[0]] == winner && gameState[possibleWin[1]] == gameState[possibleWin[0]] && gameState[possibleWin[2]] == gameState[possibleWin[1]])
            {
                return true
            }
        }
        for possibleWin in gameWinsVertical
        {
            if(gameState[possibleWin[0]] == winner && gameState[possibleWin[1]] == gameState[possibleWin[0]] && gameState[possibleWin[2]] == gameState[possibleWin[1]])
            {
                return true
            }
        }
        for possibleWin in gameWinsDiagonal
        {
            
            if(gameState[possibleWin[0]] == winner && gameState[possibleWin[1]] == gameState[possibleWin[0]] && gameState[possibleWin[2]] == gameState[possibleWin[1]])
            {
                
                return true
            }
        }
        
        return false;
    }
    
    func gameOver(winner: Int32) -> Void
    {
        
        
        
        if(winner == 1)
        {
            
            pacmanScoreInt += 1
            pacmanScore.text = String(pacmanScoreInt)
            
            let alert_game_over: UIAlertController = UIAlertController(title: "Game Over", message: "PacMan Won!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert_game_over.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: newGame))
            
            alert_game_over.addAction(UIAlertAction(title: "Quit", style: UIAlertActionStyle.default, handler: nil))
            
            
            self.present(alert_game_over, animated: true, completion: nil)
        
        
            for view in self.view.subviews
            {
                if let btn = view as? UIButton
                {
                    btn.isUserInteractionEnabled = false;
                    if(btn.currentImage != UIImage(named: "pacman.png"))
                    {
                        btn.setImage(UIImage(named: "ghost_vulnerable.png"), for: UIControlState())
                    }
                }
            }
        
        }
        else
        {
            ghostScoreInt += 1
            GhostScore.text = String(ghostScoreInt)
            
            let alert_game_over: UIAlertController = UIAlertController(title: "Game Over", message: "Ghosts Won!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert_game_over.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: newGame))
            
            alert_game_over.addAction(UIAlertAction(title: "Quit", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert_game_over, animated: true, completion: nil)
        
            for view in self.view.subviews
            {
                if let btn = view as? UIButton
                {
                    btn.isUserInteractionEnabled = false;
                }
            }
        
        }
        
        
    }
    
    
    func newGame(alert: UIAlertAction) -> Void
    {
        for view in self.view.subviews
        {
            if let btn = view as? UIButton
            {
                btn.isUserInteractionEnabled = true;
                btn.setImage(nil, for: UIControlState())
            }
        }
        player1Turn = true;
        gameState = [0,0,0,0,0,0,0,0,0]
    }
    
    


}


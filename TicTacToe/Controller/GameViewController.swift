//
//  ViewController.swift
//  TicTacToe

import UIKit

class GameViewController: UIViewController {

    var ticTacToeBoard = Board()
    var winner = Winner()
    var buttonArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateAlertForImageSelection(message: "Select your choice...")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton){
        buttonArray.append(sender)
        sender.setBackgroundImage(UIImage(named: ticTacToeBoard.updateBoardImage()), for: UIControl.State.normal)
        //All 9 button tags are initialized from 0...8 to maintain the board index
        let result = ticTacToeBoard.updateBoardStatus(buttonTag: sender.tag)
        displayresult(flag: result)
        sender.isEnabled = false
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        resetGame()
        viewDidAppear(true) //for showing imageSelection alert box for new game
    }
    
    func resetGame() {
        for button in buttonArray{
            button.setBackgroundImage(nil, for: UIControl.State.normal)
            button.isEnabled = true
        }
        buttonArray.removeAll()
        ticTacToeBoard.resetBoard()
    }
    
    func displayresult(flag: Int){
        if(flag == 0) {
            updateAlertLabel(message: "Player 1 won !!!")
        }
        if(flag == 1){
            updateAlertLabel(message: "Player 2 won !!!")
        }
        if(ticTacToeBoard.clickCount == 9 && flag == -1){
            updateAlertLabel(message: "Draw...")
        }
    }
    
    //alert box for displaying result
    func updateAlertLabel(message: String){
        let alert = UIAlertController(title: "Result:", message: message,         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { _ in
            self.resetGame()
            self.viewDidAppear(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //alert box for image selection
    func updateAlertForImageSelection(message: String){
        let alert = UIAlertController(title: "New Game:", message: message,         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "O", style: UIAlertAction.Style.default, handler: { _ in
            self.ticTacToeBoard.image = "TTTO"
        }))
        alert.addAction(UIAlertAction(title: "X", style: UIAlertAction.Style.default, handler: { _ in
            self.ticTacToeBoard.image = "TTTX"
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

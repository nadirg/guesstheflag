//
//  ViewController.swift
//  Project_2
//
//  Created by Nadir Garouche on 10/02/2023.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askQuestionCounter = 0
    var selectedFlag = ""
    
    @objc func showScore() {
        let alert = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))

        
       /*  button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        
        button1.clipsToBounds = true
        button2.clipsToBounds = true
        button3.clipsToBounds = true
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor */


        askQuestion(action: nil)

    }

    func askQuestion(action: UIAlertAction!) {
        
        askQuestionCounter += 1

        if askQuestionCounter == 10 {
                let alert = UIAlertController(title: "Game Over", message: "You have reached 10 questions.  \n Final score: \(score).", preferredStyle: .alert)
                let action = UIAlertAction(title: "New Game", style: .default, handler: { _ in
                    self.askQuestionCounter = 0
                    self.score = 0
                    self.askQuestion(action: nil)
                })
            
            
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            
                return
            }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = (countries[correctAnswer].uppercased()) + ". " + "Current Score: \(score)"

    }
    
   

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong. That's the flag of \(countries[sender.tag].uppercased())."
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
}


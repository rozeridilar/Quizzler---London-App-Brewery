//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        }
        else{
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        
    }
    
    func updateUI() {
        let totalCount = allQuestions.list.count
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1)/\(totalCount)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(totalCount)) * CGFloat(questionNumber + 1)}
    

    func nextQuestion() {
        if(questionNumber < allQuestions.list.count){
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }else{
            let alert = UIAlertController(title: "Awesome", message: "You have finished all the questions, do you wanna start over?", preferredStyle: .alert)
         
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
                
            print("End of Quiz")
            questionNumber = 0
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if(correctAnswer == pickedAnswer){
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }else{
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
       questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}

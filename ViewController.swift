//
//  ViewController.swift
//  Flashcards
//
//  Created by Keith Mathe on 2/26/22.
//

import UIKit

struct FlashCard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet var screen: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var flashCards = [FlashCard]()
    var currentFlashcard = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsViewController = self
    }   
    
    override func viewDidLoad() {
        readSavedFlashcards()
        
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        card.clipsToBounds = true
        
        if flashCards.count == 0 {
            updateFlashcard(question: "Who's the greatest Marvel hero of all time?", ans: "Tony Stark")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }


    @IBAction func didTapFlashcard(_ sender: Any) {
        frontLabel.isHidden =  !frontLabel.isHidden
    }
    //    @IBAction func didTapFlashcard(_ sender: Any) {
//
//    }
    
    func updateFlashcard(question : String, ans : String) {
        let flashcard = FlashCard (question: question, answer: ans)
        flashCards.append(flashcard)
        backLabel.text = flashcard.answer
        frontLabel.text = flashcard.question
        currentFlashcard = flashCards.count - 1
        print("Added new flashcard")
        print("Current Flashcards Count: \(flashCards.count)")
        print("Current Flashcards Index: \(currentFlashcard)")
        
    // update buttons:
        updateNextPrevButtons()
        
    // save to disk
        saveAllFlashcardsToDisk()
    }
    
//    Function for updating next and prev based on current index
    func updateNextPrevButtons() {
        if (currentFlashcard == 0) {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
        
        if (currentFlashcard == flashCards.count - 1) {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentFlashcard -= 1
        updateLabels()
        updateNextPrevButtons()
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentFlashcard += 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    func updateLabels() {
    let flashcard = flashCards[currentFlashcard]
    frontLabel.text = flashcard.question
    backLabel.text = flashcard.answer
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashCards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // log
        print("Flashcards saved to user defaults")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String : String]] {
            let savedCards = dictionaryArray.map {dictionary -> FlashCard in
            return FlashCard(question: dictionary["question"]!, answer: dictionary["answer"]!)
        }
            flashCards.append(contentsOf: savedCards)
            
    }
    
}

}

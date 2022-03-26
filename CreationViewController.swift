//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Keith Mathe on 3/13/22.
//

import UIKit

class CreationViewController: UIViewController {
    @IBOutlet weak var questionField: UITextField!
    
    
    @IBOutlet weak var answerField: UITextField!
    
    var flashcardsViewController : ViewController!
    
    @IBAction func didTapOnDone(_ sender: Any) {
        flashcardsViewController.updateFlashcard(question: (questionField.text)!, ans: (answerField.text)!)
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

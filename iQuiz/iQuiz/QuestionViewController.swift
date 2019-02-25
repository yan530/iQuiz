//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Anni Yan on 2/20/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var dataFromFirst = -1;
    
    @IBOutlet weak var question: UILabel!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch dataFromFirst {
        case 2:
            question.text = "What is fire?"
        case 1:
            question.text = "Who is Iron Man?"
        case 0:
            question.text = "What is 2+2?"
        default:
            question.text = "Hello"
        }
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

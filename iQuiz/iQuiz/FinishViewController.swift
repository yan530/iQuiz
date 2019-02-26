//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Anni Yan on 2/25/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    var correct = 0
    var total = 0
    
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = "You got " + String(correct) + " of " + String(total) + " correct!"
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

//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Anni Yan on 2/20/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

class QuestionViewController: UITableViewController{
    
    var types:[Question] = [
        Question(question: "", answer: "", answers: [])
    ];
    var select = -1
    var num = 0
    var correct = 0;
    
    @IBOutlet weak var submit: UIButton!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        if (select != -1) {
            performSegue(withIdentifier: "toAnswer", sender: types)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (select == -1) {
            submit.isEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return types[num].question
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = types[num].answers[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        submit.isEnabled = true
        select = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toAnswer") {
            let vc = segue.destination as! AnswerViewController
            vc.question = types[num].question
            vc.choice = types[num].answers
            vc.answer = types[num].answer
            vc.select = self.select
            vc.num = num
            vc.total = types.count
            vc.types = types
            vc.correct = correct
        }
    }

}

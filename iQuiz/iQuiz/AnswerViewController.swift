//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Anni Yan on 2/25/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

class AnswerViewController: UITableViewController {
    
    var types:[Question] = [
        Question(question: "", answer: "", answers: [])
    ];
    var question : String = "empty"
    var choice : [String] = ["0", "1", "2", "3"]
    var answer : String = "-1"
    var select = -1
    var num = 0
    var total = 0
    var correct = 0
    
    @IBAction func next(_ sender: Any) {
        if (num < total - 1) {
            performSegue(withIdentifier: "next", sender: AnyObject.self)
        } else {
            performSegue(withIdentifier: "end", sender: AnyObject.self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "next" && num < total - 1) {
            num += 1
            let vc = segue.destination as! QuestionViewController
            vc.num = num
            vc.types = types
            vc.correct = correct
        } else {
            let vc = segue.destination as! FinishViewController
            vc.correct = correct
            vc.total = total
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return question
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (indexPath.row == select && String(indexPath.row+1) == answer) {
            correct += 1
            cell.backgroundColor = UIColor(red:0.55, green:0.80, blue:0.64, alpha:0.3)
        } else if (indexPath.row == select) {
            cell.backgroundColor = UIColor(red:0.89, green:0.65, blue:0.69, alpha:0.3)
        } else if (String(indexPath.row+1) == answer) {
            cell.backgroundColor = UIColor(red:0.55, green:0.80, blue:0.64, alpha:0.3)
        }
        
        cell.textLabel?.text = choice[indexPath.row]

        return cell
    }
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

}
 */

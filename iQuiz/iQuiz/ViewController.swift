//
//  ViewController.swift
//  iQuiz
//
//  Created by Anni Yan on 2/18/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

struct Quiz2 {
    let name: String
    let desc: String
    let phone: String
}

class Quiz {
    
    init(name: String, descrip: String) {
        self.name = name
        self.descrip = descrip
    }
    
    var name = ""
    var descrip = ""
    
    var getName: String {
        get { return name }
    }
    
    var getDescrip: String {
        get { return descrip }
    }
}

protocol QuizRepository {
    
    func getQuiz() -> [Quiz]
    
    func saveQuiz(data: [Quiz]) -> Bool
    
    func findQuizByName(_ name: String) -> [Quiz]
}

class TestingQuizRepository : QuizRepository {
    private static var _repo : QuizRepository? = nil
    
    static var theInstance: QuizRepository {
        get {
            if _repo == nil {
                _repo = TestingQuizRepository()
            }
            return _repo!
        }
    }
    
    let localTestingData: [Quiz] = [
        Quiz(name: "Mathematics", descrip: "This is a math quiz."),
        Quiz(name: "Marvel Super Heroes", descrip: "Do you know your super heroes?"),
        Quiz(name: "Science", descrip: "Science is fun!")
    ]
    
    func getQuiz() -> [Quiz] {
        return localTestingData
    }
    
    func saveQuiz(data: [Quiz]) -> Bool {
        return true
    }
    
    func findQuizByName(_ name: String) -> [Quiz] {
        return []
    }
}

class QuizDataSource : NSObject, UITableViewDataSource {
    
    var data: [Quiz] = []
    
    init(_ elements: [Quiz]){
        data = elements
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        assert(section == 0)
        return "Names"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! TableViewCell
        
        cell.nameLabel?.text = data[indexPath.row].name
        cell.descLabel?.text = data[indexPath.row].descrip
        return cell
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak internal var tableView: UITableView!
    
    //clear button
    @IBAction internal func clearNames(_ sender: Any) {
        tableView.reloadData()
    }
    
    //alert
    @IBAction func SettingAlert(_ sender: Any) {
        let alert = UIAlertController(title: "New Alert", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: {
            print("This is hte completion handler for the present() code")
        })
    }
    
    var dataSource: QuizDataSource? = nil
    var quizRepo: QuizRepository = (UIApplication.shared.delegate as! AppDelegate).quizRepository
    
    var quiz: [Quiz] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? QuestionViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        vc.dataFromFirst = index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        quiz = quizRepo.getQuiz()
        dataSource = QuizDataSource(quiz)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}


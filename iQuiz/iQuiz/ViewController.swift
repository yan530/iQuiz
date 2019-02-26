//
//  ViewController.swift
//  iQuiz
//
//  Created by Anni Yan on 2/18/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

struct Question {
    let question: String
    let answer: String
    let answers: [String]
}

class Quiz {

    init(name: String, descrip: String, quiz: [Question]) {
        self.name = name
        self.descrip = descrip
        self.quiz = quiz
    }

    var name = ""
    var descrip = ""
    var quiz = [Question(question: "", answer : "", answers : [])]
}

var localData: [Quiz] = [
    Quiz(name: "Mathematics", descrip: "Did you pass the third grade?", quiz: math),
    Quiz(name: "Marvel Super Heroes", descrip: "Avengers, Assemble!", quiz : marvel),
    Quiz(name: "Science", descrip: "Because SCIENCE!", quiz: science)
]

let math = [
    Question(question: "What is 2+2?", answer: "1", answers: ["4", "22", "An irrational number", "Nobody knows"])
]

let marvel = [
    Question(question: "Who is Iron Man?", answer: "1", answers: ["Tony Stark", "Obadiah Stane", "A rock hit by Megadeth", "Nobody knows"]),
    Question(question: "Who founded the X-Men?", answer: "2", answers: ["Tony Stark", "Professor X", "The X-Institute", "Erik Lensherr"]),
    Question(question: "How did Spider-Man get his powers?", answer: "1", answers: ["He was bitten by a radioactive spider", "He ate a radioactive spider", "He is a radioactive spider", "He looked at a radioactive spider"])
]

let science = [
    Question(question: "What is fire?", answer: "1", answers: ["One of the four classical elements", "A magical reaction given to us by God", "A band that hasn't yet been discovered",  "Fire! Fire! Fire! heh-heh"])
]

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
    
    let localTestingData: [Quiz] = localData
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.nameLabel?.text = data[indexPath.row].name
        cell.descLabel?.text = data[indexPath.row].descrip
        return cell
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    var quizList : [Question] = []
    var dataSource: QuizDataSource? = nil
    var quizRepo: QuizRepository = (UIApplication.shared.delegate as! AppDelegate).quizRepository
    
    let jsonUrlString = "http://tednewardsandbox.site44.com/questions.json"
    
    var quiz: [Quiz] = localData
    
    @IBOutlet weak internal var tableView: UITableView!
    
    //clear button
    @IBAction internal func clearNames(_ sender: Any) {
        tableView.reloadData()
    }
    
    //alert
    @IBAction func SettingAlert(_ sender: Any) {
        let alert = UIAlertController(title: "URL", message: jsonUrlString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("check now", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"retrieve data\" alert occured.")
        }))
        self.present(alert, animated: true, completion: {
            print("This is hte completion handler for the present() code")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? QuestionViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        switch index {
        case 0:
            vc.types = math
        case 1:
            vc.types = marvel
        default:
            vc.types = science
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: jsonUrlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                //print(jsonArray)
                var type : [Quiz] = [] //Initialising Model Array
                for i in jsonArray{
                    var quiz : [Question] = []
                    let questions = i["questions"] as! [[String: Any]]
                    for j in questions {
                        quiz.append(Question(question: j["text"] as! String, answer:j["answer"] as! String, answers:j["answers"] as! [String]))
                    }
                    type.append(Quiz(name: i["title"] as! String, descrip: i["desc"] as! String, quiz: quiz))
                }
                localData = type
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        quiz = quizRepo.getQuiz()
        dataSource = QuizDataSource(quiz)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}


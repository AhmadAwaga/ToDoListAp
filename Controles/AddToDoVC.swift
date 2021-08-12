//
//  AddToDoVC.swift
//  ToDoListApp
//
//  Created by Ahmed Awaga on 5/22/21.
//

import UIKit
protocol todoitems {
    func addtodoitem(item: gettodo)
}

class AddToDoVC: UIViewController { 
    //Mark: - IBOutlet
    
    @IBOutlet weak var todotf: UITextField!
    
    @IBOutlet weak var additembtn: UIButton!{
        didSet{
            additembtn.layer.cornerRadius = additembtn.frame.height / 5
            additembtn.layer.borderWidth = 1
            additembtn.layer.borderColor = #colorLiteral(red: 0.08979427069, green: 0.1823330522, blue: 0.2820075154, alpha: 1)
        }
    }
    //Mark: - constants
    var delegate: todoitems?
    var getmylist : gettodo!
    static var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupui()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if AddToDoVC.flag == 1{
            delegate?.addtodoitem(item: getmylist)
            AddToDoVC.flag = 0
        }
        
    }
    //Mark: - IBActions
    @IBAction func addnewitembtnpressed(_ sender: UIButton) {
        if todotf.text != ""{
            getmylist = gettodo(list: todotf.text!)
            AddToDoVC.flag = 1
            self.navigationController?.popViewController(animated: true)        // when i add new item back by itself
        }
        // Aleart
        else {
            let Aleart = UIAlertController(title: "Error", message: "Empty Text Field", preferredStyle: .alert)
            let AleartAction = UIAlertAction(title: "Cncel", style: .cancel, handler: nil )
            Aleart.addAction(AleartAction)
            present(Aleart, animated: true, completion: nil)
            
        }
    }
    //Mark: - Helperfunctin
    func setupui(){

        navigationController?.navigationBar.prefersLargeTitles = false

    }
}



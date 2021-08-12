//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Ahmed Awaga on 5/22/21.
//

import UIKit
import DGElasticPullToRefresh

class ToDoListVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var ToDoarr : [gettodo] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupui()
        pulltorefresh()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableview.dg_removePullToRefresh()
        
    }
    //MARK: - IBACTION
    
    @IBAction func gotoaddvc(_ sender: UIBarButtonItem) {
        
        let addvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddToDoVC") as! AddToDoVC
        addvc.delegate = self

        self.navigationController?.pushViewController(addvc, animated: true)
    }
    
    
    //MARK:- HELPER FUNCTION
    func setupui(){
        tableview.tableFooterView = UIView()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.06681231409, green: 0.1473880112, blue: 0.2304594517, alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       // navigationController?.navigationBar.prefersLargeTitles = true
    
    }
    func pulltorefresh(){
        // pod library
  
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = #colorLiteral(red: 0.8537589598, green: 0.9015815812, blue: 0.000303351258, alpha: 1)
        tableview.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
           
            self?.tableview.dg_stopLoading()
        }, loadingView: loadingView)
        tableview.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableview.dg_setPullToRefreshBackgroundColor(tableview.backgroundColor!)
    }
  
    @objc func upbtnpressed(_ sender: UIButton){
        if sender.tag != 0 {
            ToDoarr.swapAt(sender.tag, sender.tag - 1)
            tableview.reloadData()

        }
        
    }
    
    @objc func downbtnpressed(_ sender: UIButton){
        if sender.tag != ToDoarr.count-1{
            ToDoarr.swapAt(sender.tag, sender.tag + 1)
            tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete ") { (action, view, completion) in
            self.ToDoarr.remove(at: indexPath.row)
            self.tableview.reloadData()
        }
        
        delete.image = #imageLiteral(resourceName: "pin")
        delete.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let swip = UISwipeActionsConfiguration(actions: [delete])
      //  swip.performsFirstActionWithFullSwipe = false      //if i want to stop full swip
        return swip
    }
    

}

extension ToDoListVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoListCell
        cell.ToDolbl.text = ToDoarr[indexPath.row].list
        cell.upbtn.tag = indexPath.row
        cell.downbtn.tag = indexPath.row
        cell.upbtn.addTarget(self, action: #selector(self.upbtnpressed(_ :)), for: .touchUpInside)
        cell.downbtn.addTarget(self, action: #selector(self.downbtnpressed(_ :)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.HEIGHT_SCREEN / 10
    }
}
extension ToDoListVC:todoitems{
    func addtodoitem(item: gettodo) {
        ToDoarr.append(item)
        tableview.reloadData()
    }

    
    
}

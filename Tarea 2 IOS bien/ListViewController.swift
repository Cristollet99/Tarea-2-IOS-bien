//
//  ListViewController.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 25/1/22.
//

import UIKit

class ListViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var employeeListView: UITableView!
    @IBOutlet weak var employeeLabel: UILabel!
    
    //Variables
    
    private var employeeViewModel = EmployeeViewModel()
    private var employee: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.employeeListView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomEmloyeeCell")
        employeeListView.allowsSelection = true
        employeeList()
    }
    
    
    func employeeList(){
        employeeViewModel.fetchEmployeeList { [weak self] in
            self?.employeeListView.dataSource = self
            self?.employeeListView.delegate = self
            self?.employeeListView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return employeeViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        employeeListView.deselectRow(at: indexPath, animated: true)
        employee = employeeViewModel.cellForRowAt(indexPath: indexPath)
            
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeDetail") as! EmployeeDetailViewController
                
        if let id = employee?.id{
            vc.id = id
        }
        
        self.present(vc,animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath)-> UITableViewCell{
        let cell = employeeListView.dequeueReusableCell(withIdentifier: "CustomEmloyeeCell", for: indexPath) as! ListTableViewCell
        
        employee = employeeViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(employee!)
        
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        return cell
    }
    
}




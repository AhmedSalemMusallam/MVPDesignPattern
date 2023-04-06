//
//  ViewController.swift
//  MVPDesignPattern
//
//  Created by Ahmed Salem on 06/04/2023.
//

import UIKit

class UsersViewController: UIViewController , UserPresenterDelegate{
    
    

    //Mark:- Variables
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //Mark:- present the user presenter here
    private let presenter = UserPresenter()
    
    // Collection Of users
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        
        //Table
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        //Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}

//Mark:- extenion to conform dalegation and datasource for the table view
extension UsersViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Ask presenter to handel the tap
        presenter.didTap(user: users[indexPath.row])
    }
    
    func presentUsers(users: [User]) {
        self.users = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
}


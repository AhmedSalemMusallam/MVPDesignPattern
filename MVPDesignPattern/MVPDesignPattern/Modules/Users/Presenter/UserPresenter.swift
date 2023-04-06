//
//  UserPresenter.swift
//  MVPDesignPattern
//
//  Created by Ahmed Salem on 06/04/2023.
//

import Foundation
import UIKit

//https://jsonplaceholder.typeicode.com/users

protocol UserPresenterDelegate: AnyObject
{
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

typealias PresentDelegate = UserPresenterDelegate & UIViewController

class UserPresenter
{
    weak var delegate:PresentDelegate?
    
    public func getUsers(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url){ data , _ , error in
            guard let data = data, error == nil else { return }
            
            do{
                let users = try JSONDecoder().decode([User].self, from: data)
                self.delegate?.presentUsers(users: users)
            }catch{
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresentDelegate)
    {
        self.delegate = delegate
    }
    
    public func didTap(user: User)
    {
        delegate?.presentAlert(
            title: user.name ,
            message: "\(user.name) has an email of \(user.email) & a username of \(user.username)."
        )
    }
}

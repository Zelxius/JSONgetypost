//
//  ViewController.swift
//  JsonGETYPOST
//
//  Created by Colimasoft on 02/03/22.
//

import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabla: UITableView!
    var usuarios = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJson()
    }
    
    func getJson(){
        guard let datos = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let url = URLRequest(url: datos)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            
            do {
                self.usuarios = try JSONDecoder().decode([User].self, from: data!)
                DispatchQueue.main.async {
                    self.tabla.reloadData()
                }
            } catch let error as NSError {
                print("No carga el Json", error.localizedDescription)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = usuarios[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }

    @IBAction func addPost(_ sender: UIBarButtonItem) {
    }
    
    
}


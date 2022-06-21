//
//  ViewController.swift
//  CodableDota
//
//  Created by Admin on 6/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var heroes = [Hero]()
    var fav = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        fetchJson {
            self.tableview.reloadData()
            
            var favorites = [Int]()
            
            if let fav = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
                favorites = fav
            }
            
            self.fav = favorites
            print(self.fav )
        }
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func fetchJson(completed: @escaping ()-> ()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Something stange happened")")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error!")
                return
            }
            guard data != nil else {
                print("Error: We have no data bub")
                return
            }
            do {
                self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                DispatchQueue.main.async {
                    // here we call the closure to indicate this is where the results of the fetch should be called
                    completed()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedHero = heroes[indexPath.row]
        
        //WRITE DATA ON CELL
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.textLabel?.text = selectedHero.name.capitalized
        cell.detailTextLabel?.text = selectedHero.primaryAttribute + " | " + selectedHero.attackType
        cell.imageView?.downloaded(from: URL(string: "https://api.opendota.com\((selectedHero.image))")!)
        
        //add favourite button and select image button with FILL OR UNFILL STAR
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        if fav.contains(indexPath.row)
        {
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else
        {
            button.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        button.addTarget(self, action: #selector(changeStar(sender:)), for: .touchUpInside)
        button.tag = indexPath.row
        cell.accessoryView = button
        
        return cell
    }
    
    @objc func changeStar(sender: UIButton ){
        let buttonTag = sender.tag
        
        if sender.currentImage!.isEqual(UIImage(systemName: "star")) {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
            UserDefaults.standard.favorites.append(buttonTag)
        
        }else{
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            
            if let num = UserDefaults.standard.favorites.firstIndex(of: buttonTag){
                UserDefaults.standard.favorites.remove(at: num)
            }
        }
        
    }
    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goDetails", sender: self)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.hero = heroes[(tableview.indexPathForSelectedRow?.row)!]
        }
    }
}

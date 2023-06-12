import UIKit
import Foundation

class ViewController: UIViewController, FirstViewControllerDelegate {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    var persons = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        config {
            self.tableView.reloadData()
        }

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func config(completed: @escaping() -> ()){
        let urlString = URL(string: "https://restcountries.com/v3.1/all")
    
        URLSession.shared.dataTask(with: urlString!) { data, response, err in
            if err == nil {
                do {
                    let response = try JSONDecoder().decode([Response].self, from: data!)
                    
                    print(response)

                    for r in response {
                        self.persons.append(Person(response: Response(name: r.name, region: r.region, flags: r.flags), status: false, comment: ""))
                    }
    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("Error response!")
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? InfoViewController {
            vc.person = persons[tableView.indexPathForSelectedRow!.row]
            vc.id = tableView.indexPathForSelectedRow!.row
            vc.delegate = self
        }
    }
        
    func update(text: String, id: Int) {
        persons[id].comment = text
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.myLabel?.text = persons[indexPath.row].response.name.official
        cell.myImageView?.setImage(imageUrl: self.persons[indexPath.row].response.flags.png)
        cell.myComment?.text = persons[indexPath.row].comment
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showResult", sender: self)
    }
}

import UIKit

class BasketViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet var tableBasketView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableBasketView.delegate = self
        tableBasketView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableBasketView.reloadData()
    }
}

extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Base.shared.personsBasket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasketTableViewCell

        cell.basketLabel?.text = Base.shared.personsBasket[indexPath.row].response.name.official
        cell.basketImage?.kf.setImage(with: URL(string: Base.shared.personsBasket[indexPath.row].response.flags.png))
        
        cell.person = Base.shared.personsBasket[indexPath.row]
        
        return cell
    }
}

extension BasketViewController: UITableViewDelegate {
    
    func tableBasketView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

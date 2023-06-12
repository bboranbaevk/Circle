import UIKit
import Kingfisher

class InfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var myButton: UIButton!
    @IBOutlet weak var descriptionText: UITextView!
    
    var data = ""
    @IBOutlet weak var textField: UITextField!
    
    var person: Person?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        config()
        
        for n in Base.shared.personsBasket {
            if(n.response.name.official == person?.response.name.official){
                person!.status = true
                myButton.tintColor = .red
            }
        }
        
        textField.text = data
    }
    
    func config() {
        nameLabel.text = person?.response.name.official
        imageView.kf.setImage(with: URL(string: person!.response.flags.png))
        descriptionText.text = person?.response.region
        
        myButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        myButton.tintColor = .lightGray
    }
    
    @IBAction func likeButton(_ sender: Any) {
        
        if person!.status {
            person!.status = false
            myButton.tintColor = .lightGray
            
            Base.shared.deleteFavorite(person!.response)
        }
        else {
            person!.status = true
            myButton.tintColor = .red
            
            Base.shared.saveAddress(png: (person?.response.flags.png)!, common: (person?.response.name.common)!, official: (person?.response.name.official)!, region: (person?.response.region)!)
        }
    }
    
    weak var delegate: FirstViewControllerDelegate?

    override func viewWillDisappear(_ animated: Bool) {
        if let dataTransaction = textField.text {
            delegate?.update(text: dataTransaction, id: id!)
        }
    }
    
    
}

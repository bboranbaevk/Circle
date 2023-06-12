import UIKit

class BasketTableViewCell: UITableViewCell {

    static let identifier = "BasketTableViewCell"
    
    @IBOutlet weak var basketLabel: UILabel!
    @IBOutlet weak var basketImage: UIImageView!
    
    var person: Person?
    
    @IBOutlet weak var myButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        myButton.tintColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        myButton.tintColor = .red
    }
    
    @IBAction func dede(_ sender: Any) {
        Base.shared.deleteFavorite(person!.response)
        myButton.tintColor = .lightGray
    }
}

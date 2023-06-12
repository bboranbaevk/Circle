import Foundation

class Base {
    
    let defaults = UserDefaults.standard
    static let shared = Base()
    
    var personsBasket: [Person] {
        
        get {
            if let data = defaults.value(forKey: "basket") as? Data {
                return try! JSONDecoder().decode([Person].self, from: data)
            }
            else {
                return [Person]()
            }
        }
        
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                defaults.set(data, forKey: "basket")
            }
        }
    }
    
    func saveAddress(png: String, common: String, official: String, region: String){
        let name = Name(common: common, official: official)
        let flag = Flag(png: png)
        let response = Response(name: name, region: region, flags: flag)
        
        let person = Person(response: response, status: false, comment: "")
        
        personsBasket.insert(person, at: 0)
    }
    
    
    func deleteFavorite(_ character: Response) {
        personsBasket.removeAll(where: { $0.response.name.official == character.name.official })
        UserDefaults.standard.set(try? JSONEncoder().encode(personsBasket), forKey: "basket")
    }
}

struct Person: Codable {
    let response: Response
    var status: Bool
    var comment: String
}

struct Response: Codable {
    let name: Name
    let region: String
    let flags: Flag
}

struct Name: Codable {
    let common: String
    let official: String
}

struct Flag: Codable {
    let png: String
}

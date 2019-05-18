import UIKit

var str = "Hello, playground"

class Character
{
    var name: String
    var birthYear: String
    var home: String
    var height: Int
    var eyeColor: String
    var hairColor: String
    
    init(name: String, birthYear: String, home: String, height: Int, eyeColor: String, hairColor: String)
    {
        self.name = name
        self.birthYear = birthYear
        self.home = home
        self.height = height
        self.eyeColor = eyeColor
        self.hairColor = hairColor
    }
    
    init(Character: [String: Any]){
        guard let name  = Character["name"],
            let birthYear = Character["birthYear"],
            let home = Character["home"],
            let height = Character["height"],
            let eyeColor = Character["eye_color"],
            let hairColor = Character["hair_color"]
            else {
        }
        
        self.name = name as! String
        self.birthYear = birthYear as! String
        self.home = home as! String
        self.eyeColor = eyeColor as! String
        self.hairColor = hairColor as! String
        self.height = height as! Int
    }
    


}




var randomChar = ["birth_year" : "1990",
                   "name" : "juan",
                   "home" : "Earth",
                   "height" : "55",
                   "eye_color" : "Brown",
                   "hair_color" : "Brown"
]


let me = Character(Character: randomChar)

print(me.name)

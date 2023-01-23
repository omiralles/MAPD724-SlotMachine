// Student Name: Carlos Hernandez Galvan
// Student ID: 301290263
//
// Student Name: Oscar Miralles Fernandez
// Student ID: 301250756
//
// Student Name: Yingda Zhang
// Student ID: 301275707
//

protocol GameProtocol {
    //inicialization
    func Start ()
    
    //Update every frame
    func Update ()
    
    //Check position is outside the bounds of screen
    func CheckBounds ()
    
    //A method to reset position
    func Reset ()
}


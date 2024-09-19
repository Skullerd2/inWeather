import Foundation
import CoreLocation

struct LocationModel{
    
    var main: MainDataLocation?
    
    init(main: MainDataLocation?) {
        self.main = main
    }
}

struct MainDataLocation{
    var city: String
}

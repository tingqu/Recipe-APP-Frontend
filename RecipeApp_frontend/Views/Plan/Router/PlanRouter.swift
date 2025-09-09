
import SwiftUI

@Observable class PlanRouter: BaseRouter {
    enum Destination: String, RouterDestination {
        case inbox
        
        var title: String {
            rawValue.capitalized
        }
    }
    
    //Nested views
    @ObservationIgnored override var routerDestinationTypes: [any RouterDestination.Type] {
        return [Destination.self, InboxDestination.self]
    }
    
    //MARK: - Public
    func navigate(to destination: Destination) {
        path.append(destination)
    }
}

//MARK: - InboxRouterProtocol
extension PlanRouter: InboxNavigationProtocol {
    func navigate(to destination: InboxDestination) {
        path.append(destination)
    }
}

import SwiftUI

@Observable class RecipesRouter: BaseRouter {
    typealias TransportationType = TransportationView.TransportationType
    
    enum Destination: RouterDestination {
        case transportation(type: TransportationType)
        
        var description: String {
            return switch self {
            case .transportation(let type):
                "transportation(type: \(type))"
            }
        }
    }
    
    @ObservationIgnored override var routerDestinationTypes: [any RouterDestination.Type] {
        return [Destination.self]
    }
    
    //MARK: - Public
    func navigate(to destination: Destination) {
        path.append(destination)
    }
}

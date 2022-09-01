import Foundation

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var discountCard: String? { get }
    var checkInTime: Date { get }
    var parkedTime: Int { get }
}

struct Parking {
    var vehicles: Set<Vehicle> //avoids duplicated vehicles
    var totals: (vehiclesCount: Int, earnings: Int)
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime = Date()
    var discountCard: String?
    var parkedTime: Int {
        Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    } //computed property
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
}

enum VehicleType {
    case car
    case miniBus
    case bus
    case motorcycle
    
    var tarifa: Int {
        switch self {
        case .car: return 20
        case .motorcycle: return 15
        case .miniBus: return 25
        case .bus: return 30
        }
    }
}

extension Parkable {
    
    var hasDiscountCard: Bool { discountCard != nil }
}

extension Parkable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
}


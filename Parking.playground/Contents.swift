import Foundation

struct Parking {
  var vehicles: Set<Vehicle>
}

struct Vehicle: Parkable {
  let plate: String
  let type: VehicleType
  let checkInTime = Date()
  var discountCard: String?
  var parkingDuration: Int {
    Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
  }
  
  static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
    lhs.plate == rhs.plate
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

protocol Parkable: Hashable {
  var plate: String { get }
  var type: VehicleType { get }
  var discountCard: String? { get }
  var hasDiscountCard: Bool { get }
  var checkInTime: Date { get }
  var parkingDuration: Int { get }
}

extension Parkable {
  
  var hasDiscountCard: Bool { discountCard != nil }
}

extension Parkable {
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(plate)
  }
}


import Foundation

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var discountCard: String? { get }
    var checkInTime: Date { get }
    var parkedTime: Int { get }
}

struct Parking {
    
    let maxVehicles = 20
    var vehicles: Set<Vehicle> = [] //avoids duplicated vehicles
    //var totals: (vehiclesCount: Int, earnings: Int)
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        guard vehicles.count < 20 else {
            onFinish(false)
            return
        }
        
        guard vehicles.insert(vehicle).inserted else {
            onFinish(false)
            return
        }
        
        onFinish(true)
    }
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime: Date
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
}

// Tests ejercicios
/*
var alkeParking = Parking()
let car = Vehicle(plate: "AA111AA", type: VehicleType.car, discountCard: "DISCOUNT_CARD_001")
let moto = Vehicle(plate: "B222BBB", type:
VehicleType.motorcycle, discountCard: nil)
let miniBus = Vehicle(plate: "CC333CC", type:
VehicleType.miniBus, discountCard: nil)
let bus = Vehicle(plate: "DD444DD", type: VehicleType.bus, discountCard: "DISCOUNT_CARD_002")
alkeParking.vehicles.insert(car)
alkeParking.vehicles.insert(moto)
alkeParking.vehicles.insert(miniBus)
alkeParking.vehicles.insert(bus)

let car2 = Vehicle(plate: "AA111AA", type: VehicleType.car, discountCard: "DISCOUNT_CARD_003")
print(alkeParking.vehicles.insert(car2).inserted)  // false
*/

// Test ejercicio 5
/*
*/

var alkeParking = Parking()
let vehicle1 = Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let vehicle2 = Vehicle(plate: "B222BBB", type: VehicleType.motorcycle, checkInTime: Date(), discountCard: nil)
let vehicle3 = Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle4 = Vehicle(plate: "DD444DD", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle5 = Vehicle(plate: "AA111BB", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")
let vehicle6 = Vehicle(plate: "B222CCC", type: VehicleType.motorcycle, checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")
let vehicle7 = Vehicle(plate: "CC333DD", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle8 = Vehicle(plate: "DD444EE", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")
let vehicle9 = Vehicle(plate: "AA111CC", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle10 = Vehicle(plate: "B222DDD", type: VehicleType.motorcycle, checkInTime: Date(), discountCard: nil)
let vehicle11 = Vehicle(plate: "CC333EE", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle12 = Vehicle(plate: "DD444GG", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")
let vehicle13 = Vehicle(plate: "AA111DD", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")
let vehicle14 = Vehicle(plate: "B222EEE", type: VehicleType.motorcycle, checkInTime: Date(), discountCard: nil)
let vehicle15 = Vehicle(plate: "CC333FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

let vehicle15bis = Vehicle(plate: "CC333FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: "any")

let greeting = { boolean in
    boolean ? print("Welcome to AlkeParking!") : print("Sorry, the check-in failed")
}

alkeParking.checkInVehicle(vehicle1, onFinish: greeting)
alkeParking.checkInVehicle(vehicle2, onFinish: greeting)
alkeParking.checkInVehicle(vehicle3, onFinish: greeting)
alkeParking.checkInVehicle(vehicle4, onFinish: greeting)
alkeParking.checkInVehicle(vehicle5, onFinish: greeting)
alkeParking.checkInVehicle(vehicle6, onFinish: greeting)
alkeParking.checkInVehicle(vehicle7, onFinish: greeting)
alkeParking.checkInVehicle(vehicle8, onFinish: greeting)
alkeParking.checkInVehicle(vehicle9, onFinish: greeting)
alkeParking.checkInVehicle(vehicle10, onFinish: greeting)
alkeParking.checkInVehicle(vehicle11, onFinish: greeting)
alkeParking.checkInVehicle(vehicle12, onFinish: greeting)
alkeParking.checkInVehicle(vehicle13, onFinish: greeting)
alkeParking.checkInVehicle(vehicle14, onFinish: greeting)
alkeParking.checkInVehicle(vehicle15, onFinish: greeting)

alkeParking.checkInVehicle(vehicle15bis, onFinish: greeting) //duplicated

let vehicle16 = Vehicle(plate: "CC333QW", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle17 = Vehicle(plate: "DD444QE", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_008")
let vehicle18 = Vehicle(plate: "AA111QR", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_009")
let vehicle19 = Vehicle(plate: "BB22QT", type: VehicleType.motorcycle, checkInTime: Date(), discountCard: nil)
let vehicle20 = Vehicle(plate: "CC333QY", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle21 = Vehicle(plate: "CC333QO", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)

alkeParking.checkInVehicle(vehicle16, onFinish: greeting)
alkeParking.checkInVehicle(vehicle17, onFinish: greeting)
alkeParking.checkInVehicle(vehicle18, onFinish: greeting)
alkeParking.checkInVehicle(vehicle19, onFinish: greeting)
alkeParking.checkInVehicle(vehicle20, onFinish: greeting)

alkeParking.checkInVehicle(vehicle21, onFinish: greeting) //full



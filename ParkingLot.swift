import Foundation

struct ParkingLot {
    
    enum vehicle {
        case motorcycle
        case car
        case van
    }
    
    var parkingSpaces: [Int] = []
    let motorcycleSpot: Int
    let carSpot: Int
    let vanSpot: Int
    
    init(motorcycleSpot: Int, carSpot: Int, vanSpot: Int) {
        self.motorcycleSpot = motorcycleSpot
        self.carSpot = carSpot
        self.vanSpot = vanSpot
        let totalSpots = motorcycleSpot + carSpot + vanSpot
        for _ in 0...totalSpots - 1 {
            self.parkingSpaces.append(0)
        }
    }
    
    func getEmptySpaces(start: Int, end: Int) -> Int {
        var count = 0
        for i in start...end {
            if parkingSpaces[i] == 0 {
                count += 1
            }
        }
        return count
    }
    
    func getTotalSpots() -> Int {
        return parkingSpaces.count
    }
    
    func lotIsFull() -> Bool {
        return (getEmptySpaces(start: 0, end: parkingSpaces.count - 1) == 0) ? true : false
    }

    
    func isSpecificEmpty(vehicle: vehicle) -> Bool {
        switch vehicle {
        case .motorcycle:
            let start = 0
            let end = motorcycleSpot - 1
            let emptySpaces = getEmptySpaces(start: start, end: end)
            return (emptySpaces == 0) ? true : false
        case .car:
            let start = motorcycleSpot
            let end = start + carSpot - 1
            let emptySpaces = getEmptySpaces(start: start, end: end)
            return (emptySpaces == 0) ? true : false
        case .van:
            let start = carSpot + motorcycleSpot
            let end = start + vanSpot - 1
            let emptySpaces = getEmptySpaces(start: start, end: end)
            return (emptySpaces == 0) ? true : false
        }
    }
    
    func  getSpecificSpots(vehicle: vehicle) -> Int {
        var id: Int
        var count: Int = 0
        switch vehicle {
        case .motorcycle:
            id = 1
            for i in parkingSpaces {
                if i == id {
                    count += 1
                }
            }
        case .car:
            id = 2
            for i in (motorcycleSpot)...parkingSpaces.count {
                if parkingSpaces[i] == id {
                    count += 1
                }
            }
        case .van:
            id = 3
            let carStart = motorcycleSpot
            let carEnd = motorcycleSpot + carSpot - 1
            let vanStart = carEnd + 1
            var totalCarSpotsTaken = 0
            for i in carStart...carEnd {
                if parkingSpaces[i] == id {
                    totalCarSpotsTaken += 1
                }
            }
            count += (totalCarSpotsTaken / 3)
            for i in vanStart...parkingSpaces.count - 1{
                if parkingSpaces[i] == id {
                    count += 1
                }
            }
        }
        return count
    }
    
    mutating func fillSpot(for vehicle: vehicle, with numberOfSpots: Int) {
        var spots = numberOfSpots
        switch vehicle {
        case .motorcycle:
            for i in 0...parkingSpaces.count {
                if spots == 0 {
                    break
                }
                if parkingSpaces[i] == 0 {
                    parkingSpaces[i] = 1
                    spots -= 1
                }
            }
        case .car:
            for i in (motorcycleSpot)...parkingSpaces.count {
                if spots == 0 {
                    break
                }
                if parkingSpaces[i] == 0 {
                    parkingSpaces[i] = 2
                    spots -= 1
                }
            }
        case .van:
            let carStart = motorcycleSpot
            let carEnd = carStart + carSpot - 1
            let vanStart = motorcycleSpot + carSpot
            for i in carStart...carEnd {
                if spots == 0 {
                    break
                }
                if (parkingSpaces[i] == 0) && (parkingSpaces[i+1] == 0) && (parkingSpaces[i+2] == 0) && (parkingSpaces[i+2] <= parkingSpaces[vanStart]) {
                    parkingSpaces[i] = 3
                    parkingSpaces[i+1] = 3
                    parkingSpaces[i+2] = 3
                    spots -= 1
                }
            }
            for i in vanStart...parkingSpaces.count-1 {
                if spots == 0 {
                    break
                }
                if parkingSpaces[i] == 0 {
                    parkingSpaces[i] = 3
                    spots -= 1
                }
            }
        }
        if spots == 0 {
             print("We were able to park every vehicle.")
        }else {
            print("There was not enough space, \(spots) vehicle(s) were unable to park.")
        }
            
    }
        
    
    
}
    
    //DECLARE AND TEST
var parkingLot = ParkingLot(motorcycleSpot: 5, carSpot: 5, vanSpot: 5)
let motorcycles = 5
let cars = 2
let vans = 5
parkingLot.fillSpot(for: .motorcycle, with: motorcycles)
parkingLot.fillSpot(for: .car, with: cars)
parkingLot.fillSpot(for: .van, with: vans)
print(parkingLot.parkingSpaces)

print(parkingLot.getEmptySpaces(start: 0, end: parkingLot.parkingSpaces.count-1))
print(parkingLot.isSpecificEmpty(vehicle: .van))
print(parkingLot.getTotalSpots())
print(parkingLot.getSpecificSpots(vehicle: .van))

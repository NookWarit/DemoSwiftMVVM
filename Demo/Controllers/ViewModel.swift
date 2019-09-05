import Foundation

class ViewModel {
    // Mark: - Variable
    private let network = DemoSwiftAPI()
    private var venues : [Venue] = []
    
    // Mark: - Function
    func getVenue(success: @escaping () -> Void,
                  fail: @escaping () -> Void) {
        network.getVenueExplore(completed: { response in
            if response["meta"]["code"].intValue == 200 {
                let group = response["response"]["groups"].arrayValue.first?.dictionaryValue
                let items = group?["items"]?.arrayValue
                self.venues = items?.map({ Venue(response: $0["venue"]) }) ?? []
                success()
            } else {
                fail()
            }
        })
    }
    
    func numberOfRow() -> Int {
        return venues.count
    }
    
    func getVanue(index: Int) -> (icon: String, name: String, address: String) {
        let data = venues[index]
        return (data.catIcon, data.name, data.location)
    }
        
}

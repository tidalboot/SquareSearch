
//  Critic
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation

//Critic handles all venue network requests; Any additional network requests that need to be added should be done so in here
class Critic {
    // MARK: - Local Properties 💻
    //The base endpoint shouldn't be modifiable outside of this class
    private let baseEndpoint = "https://api.foursquare.com/v2"
    
    private let clientID = "R3A1A5YH3D5BA3U3Y3QLDI14CYZKDSUSLSIIBIX0VOV12PFH"
    private let clientSecret = "LAFF1OQNFA5GLBZVBKG4SA1Y3FXJYGODL512RMZPGSS2BTS4"
    private let version = "20170901"
    
    private func authenticatedEndpoint(withQuery query: String) -> String {
        return "\(baseEndpoint)/\(query)&client_id=\(clientID)&&client_secret=\(clientSecret)&v=\(version)"
    }
    
    func getPhotoData(forVenueID venueID: String, withCompletionHandler completionAction: @escaping (Data?) -> Void) {
        //First we set up the endpoint that we want to hit
        let endpointToUse = authenticatedEndpoint(withQuery: "venues/\(venueID)/photos?limit=1")
        
        //Then we ensure that our endpoint is still a valid URL
        guard let endpointURL = URL(string: endpointToUse) else {
            completionAction(nil)
            return
        }
        
        //Create our data task
        let task = URLSession.shared.dataTask(with: endpointURL) { (rawData, rawResponse, rawError) in
            completionAction(rawData)
        }
        //And kick it off
        task.resume()
    }
    
    // MARK: - Custom Methods 🔮
    //For safety we'll always pass a typed array of Venues through to our completion block; The Venue parser also returns a typed array of venues no matter what to fit this
    func findVenues(byLocation location: String, withCompletionHandler completionAction: @escaping ([Venue]) -> Void) {
        
        //First we set up the endpoint that we want to hit
        let endpointToUse = authenticatedEndpoint(withQuery: "/venues/search?near=\(location)&limit=5")
        
        var venues = [Venue]()
        
        //Then we ensure that our endpoint is still a valid URL
        guard let endpointURL = URL(string: endpointToUse) else {
            completionAction(venues)
            return
        }
        
        //Create our data task
        let task = URLSession.shared.dataTask(with: endpointURL) { (rawData, rawResponse, rawError) in
            
            if (rawError != nil || rawData == nil) {
                completionAction(venues)
                return
            }
            
            guard let data = rawData else {
                completionAction(venues)
                return
            }
            
            venues = Venue.parseVenues(fromRawData: data)
            completionAction(venues)
        }
        //And kick it off
        task.resume()
    }
}


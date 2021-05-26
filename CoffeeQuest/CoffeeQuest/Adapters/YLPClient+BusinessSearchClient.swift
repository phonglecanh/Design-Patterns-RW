import MapKit
import YelpAPI
// 1
extension YLPClient: BusinessSearchClient {
  public func search(with coordinate: CLLocationCoordinate2D,
                     term: String,
                     limit: UInt,
                     offset: UInt,
                     success: @escaping (([Business]) -> Void),
                     failure: @escaping ((Error?) -> Void)) {
// 2
    let yelpCoordinate = YLPCoordinate(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude)
    search(
         with: yelpCoordinate,
         term: term,
         limit: limit,
         offset: offset,
         sort: .bestMatched,
         completionHandler: { (searchResult, error) in
   // 3
           guard let searchResult = searchResult,
             error == nil else {
             failure(error)
             return
   }
   // 4
           let businesses =
             searchResult.businesses.adaptToBusinesses()
           success(businesses)
       })
   } }
   // 5
   extension Array where Element: YLPBusiness {
     func adaptToBusinesses() -> [Business] {
       return compactMap { yelpBusiness in
         guard let yelpCoordinate =
           yelpBusiness.location.coordinate else {
   return nil
         }
         let coordinate = CLLocationCoordinate2D(
           latitude: yelpCoordinate.latitude,
           longitude: yelpCoordinate.longitude)
         return Business(name: yelpBusiness.name,
                         rating: yelpBusiness.rating,
                         location: coordinate)
       }
     }
   }
  

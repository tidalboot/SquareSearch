
//  Search
//  Copyright © 2017 NickJones. All rights reserved.

import Foundation
import UIKit
import SDWebImage

//Going for Search rather than something like "SearchController" as I think the inheritance from UIViewController provides this information itself
class Search: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    // MARK: - Constant Strings 🎻
    // If the app were to grow there could be an argument to move these out to a seperate class to make localisation easier; For now they're fine
    private let findingVenues = "Finding venues! \n🕵️🕵️‍♀️"
    private let noVenues = "Sorry, we couldn't find any venues for you\n😭"
    private let whatAreYouLookingFor = "Where would you like to find the best venues?\n🦄"
    
    // MARK: - Local Properties 💻
    private var searchResults: UICollectionView!
    private var helperLabel: UILabel!
    private var venues = [Venue]()
    
    // MARK: - Collection View Delegate Methods 📦
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let venueToUse = venues[indexPath.row]
        
        let searchItem = collectionView.dequeueReusableCell(withReuseIdentifier: "searchItem", for: indexPath) as! SearchItem
        
        searchItem.imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: searchItem.frame.size.width,
            height: searchItem.frame.size.height
            )
        )
        
        //NOTE: This isn't ideal as it will request the image data every time cellForItemAtIndex is called, which is pretty often.
        //Ideally this would be moved out and would also have checks around it to stop the image/URL being requested again if it has already been requested but for a first start and a POC it should be fine.
        Critic().getPhotoData(forVenueID: venueToUse.ID) { (dataReturned) in
            if (dataReturned != nil) {
                DispatchQueue.main.async {
                    searchItem.imageView.sd_setImage(with: Photo.createPhotoURL(fromRawPhotoData: dataReturned!))
                }
            }
        }
        
        //Venue Name Label
        searchItem.detailsLabel = UILabel(frame: CGRect(
            x: 10,
            y: searchItem.frame.size.height * 0.7,
            width: searchItem.frame.size.width,
            height: searchItem.frame.size.height * 0.3
            )
        )
        searchItem.detailsLabel.text = "\(venueToUse.Name) \nCheckins: \(venueToUse.Checkins)\nCategory: \(venueToUse.CategoryName)"
        searchItem.detailsLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        searchItem.detailsLabel.textColor = .white
        searchItem.detailsLabel.numberOfLines = 3
        //-----
        
        return searchItem
    }
    
    // MARK: - Search Bar Delegate Methods 🔎
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchBarText = searchBar.text {
            getVenues(withLocation: searchBarText)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchResults.alpha = 0
        }) { (_) in
            self.helperLabel.transitionText(withString: self.whatAreYouLookingFor)
        }
        
        return true
    }
    
    // MARK: - UIView Delegate Methods 👑
    //Whilst we could move a lot of this out to builder methods or elsewhere since it's only being used it feels like a waste; Better to keep it here for now
    //If we had tests around any of this then we'd definitely need to move it out to allow it to be testable. But initially I'm only interested in ensuring that our data parsing is correct and working
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        //Collection View Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: view.frame.size.width,
            height: view.frame.size.width * 0.65
        )
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        //-----
        
        //Helper Label
        helperLabel = UILabel(frame: CGRect(
            x: view.frame.size.width * 0.1,
            y: (view.frame.size.height * 0.4) - 125,
            width: view.frame.size.width * 0.8,
            height: 250
            )
        )
        helperLabel.numberOfLines = 0
        helperLabel.textColor = .darkGray
        helperLabel.textAlignment = .center
        helperLabel.font = UIFont.systemFont(ofSize: 40)
        view.addSubview(helperLabel)
        //-----
        
        //Search Bar
        let searchBar = UISearchBar(frame: CGRect(
            x: 0,
            y: 20,
            width: view.frame.size.width,
            height: 50)
        )
        searchBar.delegate = self
        view.addSubview(searchBar)
        //-----
        
        //Gallery Collection View
        let gallerySize = CGRect(
            x: 0,
            y: searchBar.frame.origin.y + searchBar.frame.size.height,
            width: view.frame.size.width,
            height: view.frame.size.height - (searchBar.frame.origin.y + searchBar.frame.size.height)
        )
        searchResults = UICollectionView(frame: gallerySize, collectionViewLayout: layout)
        searchResults.contentInset = .zero
        searchResults.delegate = self
        searchResults.dataSource = self
        searchResults.register(SearchItem.self, forCellWithReuseIdentifier: "searchItem")
        searchResults.backgroundColor = .white
        searchResults.alpha = 0
        searchResults.layoutMargins = .zero
        //-----
        
        view.addSubview(searchResults)
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Custom Methods 🔮
    private func showNewVenues() {
        helperLabel.text = ""
        searchResults.reloadData()
        searchResults.setContentOffset(.zero, animated: false)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchResults.alpha = 1
        })
    }
    
    private func getVenues(withLocation location: String = "") {
        
        helperLabel.transitionText(withString: findingVenues) {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchResults.alpha = 0
            }) { (_) in
                Critic().findVenues(byLocation: location) { (venuesReturned) in
                    DispatchQueue.main.async {
                        if (venuesReturned.isEmpty) {
                            self.helperLabel.transitionText(withString: self.noVenues)
                            return
                        } else {
                            self.venues = venuesReturned.sorted(by: {$0.Checkins > $1.Checkins})
                            self.showNewVenues()
                        }
                    }
                }
            }
        }
    }
}

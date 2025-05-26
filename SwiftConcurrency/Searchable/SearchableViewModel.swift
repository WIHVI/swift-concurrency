//
//  SearchableViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 23/05/2025.
//

import Foundation
import Combine

@MainActor
final class SearchableViewModel: ObservableObject {
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    @Published var searchScope: SearchScopeOption = .all
    @Published private(set) var allSearchScopes: [SearchScopeOption] = []
    
    let manager = RestaurantManager()
    private var cancellables: Set<AnyCancellable> = []
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    var showSearchSugestions: Bool {
        searchText.count < 4
    }
    
    enum SearchScopeOption: Hashable {
        case all
        case cuisine(option: CuisineOption)
        
        var title: String {
            switch self {
            case .all:
                return "All"
            case .cuisine(option: let option):
                return option.rawValue.capitalized
            }
        }
    }
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] (searchText, searchScope) in
                self?.filterRestaurants(searchText: searchText, searchScope: searchScope)
            }
            .store(in: &cancellables)
    }
    
    private func filterRestaurants(searchText: String, searchScope: SearchScopeOption) {
        guard !searchText.isEmpty else {
            filteredRestaurants = []
            self.searchScope = .all
            return
        }
        
        var restaurantsInScope = allRestaurants
        switch searchScope {
        case .all:
            break
        case .cuisine(option: let option):
            restaurantsInScope = allRestaurants.filter({ restaurant in
                restaurant.cuisine == option
            })
        }
        
        let search = searchText.lowercased()
        filteredRestaurants = restaurantsInScope.filter { restaurant in
//            restaurant.title.lowercased().contains(searchText.lowercased())
//            $0.title.lowercased().contains(searchText.lowercased())
            
            let titleCpntainsSearch = restaurant.title.lowercased().contains(search)
            let cuisineContainsSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
            
            return titleCpntainsSearch || cuisineContainsSearch
        }
    }
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurants()
            
            let cuisines = Set(allRestaurants.map { $0.cuisine })
            
            allSearchScopes = [.all] + cuisines.map({ cuisine in
                SearchScopeOption.cuisine(option: cuisine)
            })
        } catch {
            print(error)
        }
    }
    
    func getSearchSuggestions() -> [String] {
        guard showSearchSugestions else {
            return []
        }
        
        var suggestions: [String] = []
        
        let search = searchText.lowercased()
        
        if search.contains("it") {
            suggestions.append("Italian")
        }
        
        if search.contains("fr") {
            suggestions.append("Français")
        }
        
        return suggestions
    }
}

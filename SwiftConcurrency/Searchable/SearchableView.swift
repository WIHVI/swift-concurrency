//
//  SearchableView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 23/05/2025.
//

import SwiftUI

struct SearchableView: View {
    @StateObject private var viewModel = SearchableViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(
                    viewModel.isSearching ?
                    viewModel.filteredRestaurants :
                    viewModel.allRestaurants
                ) { restaurant in
                    restaurantRow(for: restaurant)
                }
            }
            .padding()
        }
        .navigationTitle("Restaurants")
//        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $viewModel.searchText,
            placement: .automatic,
            prompt: Text("Search restaurants...")
        )
        .searchScopes($viewModel.searchScope, scopes: {
            ForEach(viewModel.allSearchScopes, id: \.self) { scope in
                Text(scope.title)
                    .tag(scope)
            }
        })
        .searchSuggestions({
            ForEach(viewModel.getSearchSuggestions(), id: \.self) { sugestion in
                Text(sugestion)
                    .searchCompletion(sugestion)
            }
        })
        .task {
            await viewModel.loadRestaurants()
        }
    }
    
    private func restaurantRow(for restaurant: Restaurant) -> some View {
        VStack(alignment: .leading) {
            Text(restaurant.title)
                .font(.headline)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
    }
}

#Preview {
    NavigationStack {
        SearchableView()
    }
}

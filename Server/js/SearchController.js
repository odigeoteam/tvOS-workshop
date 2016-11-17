/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This class handles presenting the Search template example.
 */

 class SearchController extends DocumentController {
    
    setupDocument(document) {
        super.setupDocument(document);
        
        // Obtain references to some useful elements in the searchTemplate
        const searchTemplateElem = document.getElementsByTagName('searchTemplate').item(0);
        const searchFieldElem = document.getElementsByTagName('searchField').item(0);
        
        const resultsContainerElem = document.getElementById("resultsContainer");
        const messageElem = document.getElementById("message");
        
        // Define some search-related constants
        const baseURL = this._documentLoader.baseURL;
        const searchBaseURL = baseURL + "resources/data/destinations.json";
        const searchMediaArtworkWidth = 548;
        const searchMediaArtworkHeight = 250;
        
        // Retain the XHR between searches so it can be cancelled mid-flight
        let searchRequest;
        // Retain the query between searches to determine changes
        let searchTextCache;
        
        toggleSearchMessage(false);
        
        const searchKeyboard = searchFieldElem.getFeature("Keyboard");
        // Register an event handler for search input changes
        searchKeyboard.onTextChange = performSearchRequest;
        
        function toggleSearchMessage(bool, message) {
            if (bool) {
                // Set the message text
                if (message) {
                    messageElem.textContent = message;
                }
                // Show the message if it's hidden
                if (!messageElem.parentNode) {
                    searchTemplateElem.appendChild(messageElem);
                }
            } else {
                // Hide the message if it's visible
                if (messageElem.parentNode) {
                    searchTemplateElem.removeChild(messageElem);
                }
            }
        }
        
        function performSearchRequest() {
            // Strip leading, trailing, and multiple whitespaces from the query
            const searchText = searchKeyboard.text.trim().replace(/\s+/g, " ");
            
            // Do nothing if the query hasn't meaningfully changed
            if (searchTextCache && searchText === searchTextCache) {
                return;
            }
            // Retain this query for the next time the input changes
            searchTextCache = searchText.toLowerCase();
            
            // If there's already a search in-progress, cancel it.
            if (searchRequest && searchRequest.readyState !== XMLHttpRequest.DONE) {
                searchRequest.abort();
            }
            
            const searchURL = searchBaseURL;
            
            // Perform the search request
            searchRequest = new XMLHttpRequest();
            searchRequest.open("GET", searchURL);
            searchRequest.responseType = "json";
            searchRequest.onload = showSearchResponse;
            searchRequest.onerror = showSearchError;
            searchRequest.send();
            
            searchFieldElem.setAttribute("showSpinner", true);
        }
        
        /*
         * Show a generic error message in the search body
         */
         function showSearchError() {
            toggleSearchMessage(true, "An error occurred during your search.");
            searchFieldElem.setAttribute("showSpinner", false);
        }
        
        /*
         * Parse the XHR response and show the results or a message
         */
         function showSearchResponse() {
            // Prepare the document for new search results
            clearSearchResults();
            searchFieldElem.setAttribute("showSpinner", false);
            
            // Show the results (or lack thereof)
            const searchResponse = searchRequest.response;
            const searchResults = searchResponse.categories;
            if (searchResults.length > 0) {
                let filteredDestinations = filterDestinations(searchResults);
                appendSearchResults(filteredDestinations);
                toggleSearchMessage(false);
            } else {
                if (searchTextCache.length > 3) {
                    toggleSearchMessage(true, `No results for ${searchTextCache}.`);
                }
            }
        }
        
        /*
         * Empty the results cache and remove all results lockup elements.
         */
         function clearSearchResults() {
            // Remove all existing search results
            while (resultsContainerElem.firstChild) {
                resultsContainerElem.removeChild(resultsContainerElem.firstChild);
            }
        }
        
        function filterDestinations(results) {
            
            let filteredCategoriesArray = Array();
            
            for (var i = 0; i < results.length; i++) {
                
                let item = results[i];
                let filteredDestinations = item.destinations.filter(function(el) { return el.name.toLowerCase().indexOf(searchTextCache) !== -1 });
                
                if (filteredDestinations.length > 0) {
                    let clone = Object.assign({}, item);
                    clone.destinations = filteredDestinations;
                    filteredCategoriesArray.push(clone);
                }

            };
            
            return filteredCategoriesArray;            
        }
        
        /*
         * Create lockup elements for the search results and cache
         * the data to be referenced by the selection handler.
         */
         function appendSearchResults(results) {
            // Create new lockups for the results
            results.forEach(function(item, index) {

                const shelfElem = document.createElement("shelf");
                shelfElem.setAttribute("class", "3ColumnGrid");
                
                const headerElem = document.createElement("header");
                const titleElem = document.createElement("title");
                titleElem.textContent = item.name;
                headerElem.appendChild(titleElem);
                shelfElem.appendChild(headerElem);
                
                const sectionElem = document.createElement("section");
                
                item.destinations.forEach(function(item, index) { sectionElem.appendChild(createLockupWithItem(item)); });
                
                shelfElem.appendChild(sectionElem);
                resultsContainerElem.appendChild(shelfElem);
                
            });
        }

        /*
         * Create lockup containing data from a search result item.
         * Shows an image, title, and subtitle in the lockup.
         */
         function createLockupWithItem(item) {
            const lockupElem = document.createElement("lockup");
            const imgElem = document.createElement("img");
            const overlayElem = document.createElement("overlay");
            const titleElem = document.createElement("title");
            
            imgElem.setAttribute("class", "imgGradient");
            imgElem.setAttribute("src", baseURL + item.image);
            imgElem.setAttribute("width", searchMediaArtworkWidth);
            imgElem.setAttribute("height", searchMediaArtworkHeight);
            lockupElem.appendChild(imgElem);
            
            titleElem.setAttribute("class", "gradientOverlayTitle");
            titleElem.textContent = item.name;
            overlayElem.appendChild(titleElem);
            
            if (item.description !== null) {
                const subtitleElem = document.createElement("subtitle");
                subtitleElem.setAttribute("class", "gradientOverlaySubtitle");
                subtitleElem.textContent = item.description;
                overlayElem.appendChild(subtitleElem);
            }
            lockupElem.appendChild(overlayElem);
            
            return lockupElem;
        }
    }
    
}

registerAttributeName('searchDocumentURL', SearchController);

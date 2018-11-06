---
layout: null
---
(function () {
	function getQueryVariable(variable) {
		var query = window.location.search.substring(1),
			vars = query.split("&");

		for (var i = 0; i < vars.length; i++) {
			var pair = vars[i].split("=");

			if (pair[0] === variable) {
				return decodeURIComponent(pair[1].replace(/\+/g, '%20')).trim();
			}
		}
	}

	function displaySearchResults(results, query) {
		var searchResultsEl = document.getElementById("search-results"),
			searchProcessEl = document.getElementById("search-process");

		if (results.length) {
			var resultsHTML = "";
			results.forEach(function (result) {
				var item = window.data[result.ref],
					contentPreview = getPreview(query, item.content, 170),
					titlePreview = getPreview(query, item.title);

				let category = item.categories.split(',')[0]
				if (category === 'Decentraland') {
					category = 'general'
				}

				resultsHTML += '<li>' +
					'<a href="{{ site.baseurl }}' + item.url.trim() + '">' +
						'<div>' +
							'<div class="icon">' +
								'<img src="{{ site.baseurl }}/images/sets/' + category + '.svg" />' +
							'</div>' +
							'<div>' +
								'<h4>' + titlePreview + '</h4>' +
								'<p>' + contentPreview + '</p>' +
							'</div>' +
						'</div>' +
					'</a>' +
				'</li>';
			});

			searchResultsEl.innerHTML = resultsHTML;
			searchProcessEl.innerText = "Search";
		} else {
			searchResultsEl.style.display = "none";
			searchProcessEl.innerText = "No";
		}
	}

	window.index = lunr(function () {
		this.field("id");
		this.field("title", {boost: 10});
		this.field("categories");
		this.field("url");
		this.field("content");
	});

	var query = decodeURIComponent((getQueryVariable("q") || "").replace(/\+/g, "%20")),
		searchQueryContainerEl = document.getElementById("search-query-container"),
		searchQueryEl = document.getElementById("search-query");

	searchQueryEl.innerText = query;
	searchQueryContainerEl.style.display = "inline";

	for (var key in window.data) {
		window.index.add(window.data[key]);
	}

	displaySearchResults(window.index.search(query), query); // Hand the results off to be displayed
})();
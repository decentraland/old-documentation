const filterOptions = {
  hide: true,
  selection: {},
}

function isDropdownHideable() {
  return filterOptions.hide
}

function setIsDropdownHideable(isHideable) {
  filterOptions.hide = isHideable
}

function hideDropdown($filter) {
  setIsDropdownHideable(true)
  $filter.dropdown("hide")
}

function addFilter(category, value) {
  const selection = filterOptions.selection
  selection[category] = (selection[category] || new Set()).add(value)
}

function removeFilter(category, value) {
  const selection = filterOptions.selection
  if (selection[category]) {
    selection[category].delete(value)
    if (selection[category].size === 0) {
      delete selection[category]
    }
  }
}

function handleCheckboxClick(checkbox) {
  const isChecked = checkbox.prop("checked")
  const category = checkbox.data("category")
  const value = checkbox.data("value")
  const selection = filterOptions.selection
  const checkCounter = checkbox.closest(".item").find(".checks")

  if (isChecked) {
    addFilter(category, value)
  } else {
    removeFilter(category, value)
  }

  if (selection[category]) {
    checkCounter.text(selection[category].size)
  } else {
    checkCounter.text("")
  }
}

function handleCheckboxSectionClick(checkbox) {
  checkbox.prop("checked", !checkbox.prop("checked"))
  handleCheckboxClick(checkbox)
}

function applyFilters($filter, $partnerCards) {
  const categories = Object.keys(filterOptions.selection)

  $partnerCards.each((_, partnerCard) => {
    const $partnerCard = $(partnerCard)
    let partnerMatches = true

    for (const category of categories) {
      const partnerCategoryValues = $partnerCard
        .attr(`data-${category.toLowerCase()}`)
        .split(";")
      const filteredValues = partnerCategoryValues.filter((value) =>
        filterOptions.selection[category].has(value)
      )
      if (filteredValues.length === 0) {
        partnerMatches = false
        break
      }
    }

    if (partnerMatches) {
      $partnerCard.show()
    } else {
      $partnerCard.hide()
    }
  })

  hideDropdown($filter)
}

function clearFilters($checkboxs, $checkCounters) {
  filterOptions.selection = {}
  $checkboxs.prop("checked", false)
  $checkCounters.text("")
}

import Foundation

enum Region {

    case europe, asia, africa, americas, world, oceania

    var title: String {
        switch self {
        case .europe: return "Europe"
        case .asia: return "Asia"
        case .africa: return "Africa"
        case .oceania: return "Oceania"
        case .americas: return "Americas"
        case .world: return "World"
        }
    }
}

// MARK: - Countries

extension Region {

    var countries: [String] {
        switch self {
        case .europe: return europeCountries
        case .asia: return asiaCountries
        case .africa: return africaCountries
        case .oceania: return []
        case .americas: return americaCountries
        case .world: return allCountries
        }
    }

    var europeCountries: [String] {
        [
            "Albania",
            "Andorra",
            "Austria",
            "Belarus",
            "Belgium",
            "Bosnia Herzegovina",
            "Bulgaria",
            "Croatia",
            "Czech Republic",
            "Denmark",
            "Finland",
            "Estonia",
            "France",
            "Georgia",
            "Germany",
            "Greece",
            "Hungary",
            "Iceland",
            "Ireland",
            "Italy",
            "Kosovo",
            "Latvia",
            "Liechtenstein",
            "Lithuania",
            "Luxembourg",
            "Macedonia",
            "Malta",
            "Moldova",
            "Monaco",
            "Montenegro",
            "Netherlands",
            "Norway",
            "Poland",
            "Portugal",
            "Romania",
            "San Marino",
            "Serbia",
            "Slovakia",
            "Slovenia",
            "Spain",
            "Sweden",
            "Switzerland",
            "Ukraine",
            "United Kingdom",
            "Vatican City",
        ]
    }
    var asiaCountries: [String] {
        [
            "Afghanistan",
            "Armenia",
            "Azerbaijan",
            "Bahrain",
            "Bangladesh",
            "Bhutan",
            "Brunei",
            "Cambodia",
            "China",
            "Cyprus",
            "India",
            "Indonesia",
            "Iran",
            "Iraq",
            "Israel",
            "Japan",
            "Jordan",
            "Kazakhstan",
            "Kuwait",
            "Kyrgyzstan",
            "Laos",
            "Lebanon",
            "Malaysia",
            "Maldives",
            "Mongolia",
            "Myanmar",
            "Nepal",
            "North Korea",
            "Oman",
            "Pakistan",
            "Philippines",
            "Qatar",
            "Russia",
            "Saudi Arabia",
            "Singapore",
            "South Korea",
            "Sri Lanka",
            "Syria",
            "Taiwan",
            "Tajikistan",
            "Thailand",
            "Turkey",
            "Turkmenistan",
            "United Arab Emirates",
            "Uzbekistan",
            "Vietnam",
            "Yemen",
        ]
    }
    var africaCountries: [String] {
        [
            "Algeria",
            "Angola",
            "Benin",
            "Botswana",
            "Burkina Faso",
            "Burundi",
            "Cameroon",
            "Cape Verde",
            "Central-African Republic",
            "Chad", "Comoros",
            "Congo-Brazzaville",
            "Congo-Kinshasa",
            "Djibouti",
            "Egypt",
            "Equatorial Guinea",
            "Eritrea",
            "Ethiopia",
            "Gabon",
            "Gambia",
            "Ghana",
            "Guinea-Bissau",
            "Guinea",
            "Ivory Coast",
            "Kenya",
            "Lesotho",
            "Liberia",
            "Libya",
            "Madagascar",
            "Malawi",
            "Mali",
            "Mauritania",
            "Mauritius",
            "Morocco",
            "Mozambique",
            "Namibia",
            "Niger",
            "Nigeria",
            "Rwanda",
            "Sao Tome and Principe",
            "Senegal",
            "Sierra Leone",
            "Somalia",
            "South Africa",
            "South Sudan",
            "Sudan",
            "Swaziland",
            "Tanzania",
            "The Seychelles",
            "Togo",
            "Tunisia",
            "Uganda",
            "Zambia",
            "Zimbabwe",
        ]
    }
    var americaCountries: [String] {
        [
            "Antigua and Barbuda",
            "Argentina",
            "Bahama",
            "Barbados",
            "Belize",
            "Bolivia",
            "Brazil",
            "Canada",
            "Chile",
            "Colombia",
            "Costa Rica",
            "Cuba",
            "Dominica",
            "Dominican Republic",
            "Ecuador",
            "El Salvador",
            "Grenada",
            "Guatemala",
            "Guyana",
            "Haiti",
            "Honduras",
            "Jamaica",
            "Mexico",
            "Nicaragua",
            "Panama",
            "Paraguay",
            "Peru",
            "Saint Kitts and Nevis",
            "Saint Lucia",
            "Saint Vincent & Grenadines",
            "Suriname",
            "The United States",
            "Trinidad and Tobago",
            "Uruguay",
            "Venezuela",
        ]
    }
    var allCountries: [String] {
        return europeCountries + asiaCountries + africaCountries + americaCountries
    }
}

// MARK: - UserDefaults

extension Region {

    var flagGameScoreKey: String {
        switch self {
        case .europe: return "ScoreEurope"
        case .asia: return "ScoreAsia"
        case .africa: return "ScoreAfrica"
        case .oceania: return "ScoreOceania"
        case .americas: return "ScoreAmericas"
        case .world: return "ScoreWorld"
        }
    }

    var flagGamePlayerLevelKey: String {
        switch self {
        case .europe: return "LevelEurope"
        case .asia: return "LevelAsia"
        case .africa: return "LevelAfrica"
        case .oceania: return "LevelOceania"
        case .americas: return "LevelAmericas"
        case .world: return "LevelWorld"
        }
    }

    var flagGameStreakKey: String {
        switch self {
        case .europe: return "StreakEurope"
        case .asia: return "StreakAsia"
        case .africa: return "StreakAfrica"
        case .oceania: return "StreakOceania"
        case .americas: return "StreakAmericas"
        case .world: return "StreakWorld"
        }
    }
}



import Foundation

struct Submsissions: Codable, Hashable, Identifiable {
	let cik: String
	let entityType: String
	let sic: String
	let sicDescription: String
	let insiderTransactionForOwnerExists: Int
	let insiderTransactionForIssuerExists: Int
	let name: String
	let tickers: [String]
	let exchanges: [String]
	let ein: String
	let description: String
	let website: String
	let investorWebsite: String
	let category: String
	let fiscalYearEnd: String
	let stateOfIncorporation: String
	let stateOfIncorporationDescription: String
	let addresses: TheAddresses
	let phone: String
	let flags: String
	let filings: Filings

	var id: UUID { UUID() }
}

struct TheAddresses: Codable, Hashable, Identifiable {
	let mailing: Address
	let business: Address

	var id: UUID { UUID() }
}

struct Filings: Codable, Hashable, Identifiable {
	let recent: Recent
	var id: UUID { UUID() }
}

struct Recent: Codable, Hashable, Identifiable {
	let accessionNumber: [String]
	let filingDate: [String]
	let reportDate: [String]
	let acceptanceDateTime: [String]
	let act: [String]
	let form: [String]
	let fileNumber: [String]
	let filmNumber: [String]
	let items: [String]
	let type: [String]
	let primaryDocument: [String]
	let primaryDocDescription: [String]

	var id: UUID { UUID() }

	private enum CodingKeys: String, CodingKey {
		case accessionNumber, filingDate, reportDate
		case acceptanceDateTime, act, form, fileNumber
		case filmNumber, items
		case type = "core_type"
		case primaryDocument, primaryDocDescription
	}

	var accessionNumbersWithoutDashes: [String] {
		return accessionNumber.map { $0.withoutDashes }
	}
}


func getSubmissions() throws -> Submsissions {
	let urlString = "/Users/advocatesclose/Downloads/submissions/CIK0000000020.json"
	let url = URL(fileURLWithPath: urlString)
	let data = try Data(contentsOf: url)
	let submissions = try JSONDecoder().decode(Submsissions.self, from: data)
	return submissions
}

struct Address: Codable, Hashable, Identifiable {
	let street1: String
	let street2: String
	let city: String
	let stateOrCountry: String
	let zipCode: String
	let stateOrCountryDescription: String

	var id: UUID { UUID() }
}

extension String {
	var withoutDashes: String {
		return self.replacingOccurrences(
			of: #"-"#,
			with: "",
			options: .regularExpression
		)
	}
}

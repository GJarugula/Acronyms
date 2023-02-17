//
//  AcronymViewModel.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import Foundation
import Combine

enum FetchableState {
    case fetching
    case idle
}

final class AcronymsInfoViewModel: ObservableObject {

    @Published var response: [AcronymResponse] = []

    @Published private(set) var state: FetchableState = .idle
    @Published var showErrorAlert: Bool = false

    let title: String = "Acronyms Information"

    let textFieldHeader: String = "Enter Acronym here"

    let buttonTitle: String = "Find"

    var isResultHidden: Bool = true
    var errorAlertTitle: String = "Sorry, something went wrong"
    var errorAlertMessage: String = ""

    let service: AcronymsInfoService

    init(service: AcronymsInfoService = AcronymLongformService()) {
        self.service = service
    }

    var longforms: [LongForm] = []
    var shortform: String = ""

    var subscription: AnyCancellable!

    var result: String {
        if !longforms.isEmpty {
            var longformsString = ""
            longforms.forEach { longform in
                longformsString.append("\(longform.longform!)\n ")
            }
            if !longformsString.isEmpty {
                if longforms.count > 1 {
                    return "Acronyms available for \(shortform) are:\n \(longformsString)"
                } else {
                    return "Acronym available for \(shortform) is:\n \(longformsString)"
                }
            }
        }
        return "No Acronym Information Found"
    }

    private let url: String = "http://www.nactem.ac.uk/software/acromine/dictionary.py"

    func fetchAcronymDetails(for query: String) {
        self.state = .fetching
        self.shortform = query
        subscription = service.getLongform(for: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] in
                self?.state = .idle
                switch $0 {
                case .failure(let error):
                    self?.errorAlertMessage = error.localizedDescription
                    self?.showErrorAlert = true
                case .finished:
                    print("finished")
                    self?.showErrorAlert = false
                }
            }, receiveValue: {[weak self] in
                guard let self = self else { return }
                self.longforms = $0
                self.state = .idle
                self.isResultHidden = false
            })

    }
}

//
//  AcronymsInfoView.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import SwiftUI

struct AcronymsInfoView: View {
    @ObservedObject var viewModel: AcronymsInfoViewModel

    @State private var acronym: String = ""

    init() {
        viewModel = AcronymsInfoViewModel()
    }

    private var acronymInputField: some View {
        VStack(alignment: .leading) {
            Text(viewModel.textFieldHeader)
                .font(.system(size: 16))
            TextField("", text: $acronym)
                .border(Color(red: 0.847, green: 0.847, blue: 0.847))
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    private var searchButton: some View {
        VStack {
            Button(viewModel.buttonTitle) {
                viewModel.fetchAcronymDetails(for: acronym)
            }
            .buttonStyle(PlainButtonStyle())
            .font(.system(size: 24))
            .foregroundColor(Color(red: 1, green: 1, blue: 1))
            .frame(maxWidth: .infinity, minHeight: 48, alignment: .center)
            .background(Color(red: 0, green: 0.467, blue: 0.784))
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }

    private var resultLabel: some View {
        VStack(alignment: .leading) {
            Text(viewModel.result)
                .font(.system(size: 16, weight: .bold))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    switch viewModel.state {
                    case .fetching:
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    case .idle:
                        VStack {
                            acronymInputField
                            searchButton
                            Spacer()
                            resultLabel
                                .isHidden(viewModel.isResultHidden)
                            Spacer()
                        }.padding()
                    }
                }
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(title: Text(viewModel.errorAlertTitle),
                          message: Text(viewModel.errorAlertMessage),
                          dismissButton: .default(Text("OK")))
                }
                .navigationTitle(viewModel.title)
            }
        }
    }
}

struct AcronymsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AcronymsInfoView()
    }
}

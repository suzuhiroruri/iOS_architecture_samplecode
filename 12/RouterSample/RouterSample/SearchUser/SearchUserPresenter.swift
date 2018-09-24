//
//  SearchUserPresenter.swift
//  RouterSample
//
//  Created by Kenji Tanaka on 2018/09/24.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import Foundation
import GitHub

protocol SearchUserPresenterProtocol {
    var users: [User] { get }
    func user(forRow row: Int) -> User?
    func didTapSearchButton(text: String)
}

class SearchUserPresenter: SearchUserPresenterProtocol {
    private(set) var users: [User] = []

    private var view: SearchUserViewProtocol!
    private var model: SearchUserModelProtocol!
    init(view: SearchUserViewProtocol, model: SearchUserModelProtocol) {
        self.view = view
        self.model = model
    }

    func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }

    func didTapSearchButton(text: String) {
        let query = text
        model.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.view.reloadTableView()
            case .failure(let error):
                // TODO: Error Handling
                ()
            }
        }
    }
}
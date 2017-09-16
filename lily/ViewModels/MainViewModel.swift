//
//  MainViewModel.swift
//  lily
//
//  Created by Nathan Chan on 9/14/17.
//  Copyright © 2017 Nathan Chan. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func mainViewDidClickLogout(_ mainViewModel: MainViewModel)
    func mainView(_ mainViewModel: MainViewModel, didSelectContest contest: Contest)
    func mainView(_ mainViewModel: MainViewModel, didSelectMedia media: Media)
}

class MainViewModel {
    var isLoggedIn: Bool!
    private(set) var contests: [Contest]?
    private(set) var media: [Media]?
    let dataProvider: DataProvider!
    
    // used by AppCoordinator
    weak var delegate: MainViewModelDelegate?
    
    init(dataProvider: DataProvider = TestInstagramDataProvider(), isLoggedIn: Bool = false) {
        self.dataProvider = dataProvider
        self.isLoggedIn = isLoggedIn
    }
    
    //MARK: - Events

    var didGetContests: (() -> Void)?
    var didGetMediaForUser: (() -> Void)?
    
    //MARK: - Private
    
    private func didGetContests(contests: [Contest]?) {
        self.contests = contests
        self.didGetContests?()
    }
    
    private func didGetMediaForUser(media: [Media]?) {
        self.media = media
        self.didGetMediaForUser?()
    }
    
    //MARK: - Actions
    
    func didClickLogout() {
        self.delegate?.mainViewDidClickLogout(self)
    }
    
    func didSelectContest(at indexPath: IndexPath) {
        if let contests = contests {
            self.delegate?.mainView(self, didSelectContest: contests[indexPath.row])
        }
    }
    
    func getMedia() {
        dataProvider.getMediaForUser(completion: self.didGetMediaForUser)
    }
    
    func getContests() {
        dataProvider.getContestsForUser(completion: self.didGetContests)
    }
    
    func getPublicContests() {
        dataProvider.getPublicContests(completion: self.didGetContests)
    }
}

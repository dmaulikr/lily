//
//  MainViewModel.swift
//  lily
//
//  Created by Nathan Chan on 9/14/17.
//  Copyright © 2017 Nathan Chan. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func mainViewDidClickCreateContest(_ mainViewModel: MainViewModel)
    func mainView(_ mainViewModel: MainViewModel, didSelectContest contest: Contest)
    func mainView(_ mainViewModel: MainViewModel, didSelectMedia media: Media)
}

class MainViewModel {
    private(set) var contests: [Contest]?
    private(set) var media: [Media]?
    let dataProvider: DataProvider!
    
    // used by AppCoordinator
    weak var delegate: MainViewModelDelegate?
    
    init(dataProvider: DataProvider = TestInstagramDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    //MARK: - Events

    var didGetContestsForUser: (() -> Void)?
    var didGetMediaForUser: (() -> Void)?
    
    //MARK: - Private
    
    private func didGetContestsForUser(contests: [Contest]?) {
        self.contests = contests
        self.didGetContestsForUser?()
    }
    
    private func didGetMediaForUser(media: [Media]?) {
        self.media = media
        self.didGetMediaForUser?()
    }
    
    //MARK: - Actions
    
    func didClickLogin() {
        print("didClickLogin")
    }
    
    func didClickCreateContest() {
        self.delegate?.mainViewDidClickCreateContest(self)
    }
    
    func didSelectMedia(at indexPath: IndexPath) {
        if let media = media {
            self.delegate?.mainView(self, didSelectMedia: media[indexPath.row])
        }
    }
    
    func didSelectContest(_ contest: Contest) {
        self.delegate?.mainView(self, didSelectContest: contest)
    }
    
    func getMedia() {
        dataProvider.getMediaForUser(completion: self.didGetMediaForUser)
    }
    
    func getContestsForUser() {
        dataProvider.getContestsForUser(completion: self.didGetContestsForUser)
    }
}

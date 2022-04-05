//
//  ShowEpisodeViewModel.swift
//  PresentationLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DomainLayer

class ShowEpisodeViewModel {
    
    private let showEpisodeInteractorProtocol: ShowEpisodeInteractorProtocol
   
    init(showEpisodeInteractorProtocol: ShowEpisodeInteractorProtocol) {
        self.showEpisodeInteractorProtocol = showEpisodeInteractorProtocol
    }
}

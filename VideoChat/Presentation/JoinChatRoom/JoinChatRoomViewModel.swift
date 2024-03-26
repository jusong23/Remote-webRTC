//
//  JoinChatRoomViewModel.swift
//  VideoChat
//
//  Created by jusong on 3/26/24.
//

import Foundation
import SwiftUI

class JoinChatRoomViewModel: ObservableObject {
    let videoChatRepository = VideoChatRepository()
    @Published var chatRooms: [(String, ChatRoom)] = []
    var chatRoomsStream: AsyncThrowingStream<[(String, ChatRoom)], Error> {
        get {
            videoChatRepository.getChatRooms()
        }
    }
    
    deinit {
        print("JoinChatRoomViewModel deinit")
    }
}

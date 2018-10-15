
//
//  FMPlayDetailModle.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/15.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import HandyJSON

struct FMPlayDetailModle: HandyJSON {
    var data :PlayDetailModle?
    var ret: Int = 0
    var msg: String?

}

struct PlayDetailModle: HandyJSON {
    var isOfflineHidden: Bool?
    var album: album?
    var isShowCommunity: Bool?
    var user :user?
    var tracks :tracks?
    
}
struct album: HandyJSON {
    var shortIntro: String?
    var albumId:Int = 0
    var categoryId:Int = 0
    var categoryName:String?
    var title:String?
    var coverLarge:String?
    var createdAt:NSInteger = 0
    var updatedAt:NSInteger = 0
    var uid:Int = 0
    var nickname:String?
    var isVerified:Bool = false
    var avatarPath:String?
    var intro:String?
    var hasRecs:Bool = false
    var isNoCopyright:Bool = false
    var saleScope:Int = 0
    var shareSupportType:Int = 0
    var introRich:String?
    var shortIntroRich:String?
    var tags:String?
    var tracks:Int = 0
    var shares:Int = 0
    var outline:String?
    var subscribeCount:Int = 0
    var hasNew:Bool = false
    var isFavorite:Bool = false
    var playTimes:NSInteger = 0
    var lastUptrackAt:NSInteger = 0
    var lastUptrackId:NSInteger = 0
    var lastUptrackTitle:String?
    var lastUptrackCoverPath:String?
    var status:Int = 0
    var serializeStatus:Int = 0
    var serialState:Int = 0
    var playTrackId:Int = 0
    var isPublic:Bool = false
    var autoStart:Bool = false
    var isRecordDesc:Bool = false
    var isPaid:Bool = false
    var refundSupportType:Int = 0
    var canShareAndStealListen:Bool = false
    var canInviteListen:Bool = false
    var buyNotes:String?
    var other_title:String?
    var other_content:String?
    var detailCoverPath:String?
    var personalDescription:String?
    var isVip:Bool = false
    var isDraft:Bool = false
    var isDefault:Bool = false
    var is_default:Bool = false
    var canAutoBuy:Bool = false
    var vipFreeType:Int = 0
    var offlineType:Int = 0
    var offlineReason:Int = 0
    var unReadAlbumCommentCount:Int = 0
    var type:Int = 0
    var customTitle:String?
    var customSubTitle:String?
}


struct user: HandyJSON {
    var uid:Int = 0
    var nickname:String?
    var isVerified:Bool = false
    var isFollowed:Bool = false
    var smallLogo:String?
    var ptitle:String?
    var personDescribe:String?
    var personalSignature:String?
    var followers:Int = 0
    var followings:Int = 0
    var tracks:Int = 0
    var albums:Int = 0
    var anchorGrade:Int = 0
    var verifyType:Int = 0
    var liveRoomId:Int = 0
    var liveStatus:Int = 0
}


struct tracks: HandyJSON {
    var maxPageId: Int = 0
    var pageSize: Int = 0
    var totalCount: Int = 0
    var pageId: Int = 0
    var list: [list]?
  
}

struct list: HandyJSON {
    var trackId:Int = 0
    var uid:Int = 0
    var duration:Int = 0
    var albumId:Int = 0
    var type:Int = 0
    var relatedId:Int = 0
    var orderNo:Int = 0
    var processState:Int = 0
    var createdAt:Int = 0
    var userSource:Int = 0
    var opType:Int = 0
    var likes:Int = 0
    var playtimes:Int = 0
    var comments:Int = 0
    var shares:Int = 0
    var status:Int = 0
    var isPaid:Bool = false
    var isVideo:Bool = false
    var isDraft:Bool = false
    var isRichAudio:Bool = false
    var isHoldCopyright:Bool = false
    var isPublic:Bool = false
    var playUrl64:String?
    var playUrl32:String?
    var playPathHq:String?
    var playPathAacv164:String?
    var playPathAacv224:String?
    var title:String?
    var coverSmall:String?
    var coverMiddle:String?
    var coverLarge:String?
    var nickname:String?
    var smallLogo:String?
}

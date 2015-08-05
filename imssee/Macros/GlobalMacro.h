//
//  GlobalMacro.h
//  Homels
//
//  Created by 鑫易 on 14/12/23.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

/**
 *  该类主要用要整理应用所有的请求接口的宏
 */

#ifndef Homels_GlobalMacro_h
#define Homels_GlobalMacro_h

/**
 *  @desc 公共接口
 */
#define Request_HTTP @"http://192.168.1.100:8080/mobile/"
#define ImagePath_IP @"http://192.168.1.100:8080"

/**
 *  @desc 新闻荟萃
 */
#define SuiSheQu_URL @"communityNewsList_J.jspx"

#define MyCommunity_URL @"communityNewsList_J.jspx"

#define PersonPublishNewsList_URL @"myNewsList_J.jspx"

#define PersonPublishNewsSave_URL @"newsSave_J.jspx"

#define PersonPublishNewsDelete_URL @"newsDelete_J.jspx"

#define PersonPublishNewsCancel_URL @"newsCancel_J.jspx"

#define CityNewsList_URL @"cityNewsList_J.jspx"

#define InternationalNewsList_URL @"newsList_J.jspx"

#define PublishNews_URL @"newsSave_J.jspx"

#define CommentList_URL @"commentList_J.jspx"

#define CommentSave_URL @"commentSave_J.jspx"

/**
 *  @desc 物管、街道、业主委员会
 */
//#define WuGuanCommonUsePhoneList_URL @"pm_phonesList_J.jspx"
//#define WuGuanPeopleInfoList_URL @"pm_usersList_J.jspx"
//#define WuGuanChargeStandardList_URL @"pm_chargestandardList_J.jspx"
//#define WuGuanIntroduceList_URL @"propertymanageList_J.jspx"

#define WuGuanCommonUsePhoneList_URL @"getpmphones_J.jspx"

#define WuGuanPeopleInfoList_URL @"getpmusers_J.jspx"

#define WuGuanChargeStandardList_URL @"getpmcharge_J.jspx"

#define WuGuanIntroduceList_URL @"getpropertymanage_J.jspx"

#define WuGuanMessageSave_URL @"messageSave_J.jspx"

#define YeZhuWeiOwnerUserList_URL @"ownerUserList_J.jspx"

#define YeZhuWeiIntroduceList_URL @"ownerList_J.jspx"

#define JuWeiIntroduceList_URL @"streetList_J.jspx"

#define JuWeiCommonUsePhoneList_URL @"streetphonesList_J.jspx"

#define JuWeiGuideList_URL @"streetguideList_J.jspx"

/**
 *  @desc 其他
 */
#define UserInfo_URL @"memberDetail_J.jspx"

#endif

//
//  StatusCode.swift
//  LIC
//
//  Created by 温红权 on 15/3/18.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

struct StatusCode {
    
    
    /// 临时布防
    static var ARMING=1;
    
    /// 临时不布防
    static var UNARMING=0;
    
    /// 监控开
    static var PERIOD_OPEN=1;
    
    /// 监控关
    static var PERIOD_CLOSE=0;
    
    /// 已读
    static var READ=1;
    
    /// 未读
    static var UNREAD=0;
    
    /// 常见问题
    static var FAQ=201;
    
    /// 什么是乐行宝二维码
    static var LX_QRCODE_Q=201002;
    
    /// 如何添加临时监控
    static var HOW_ADD_EBIKE_PERIOD_Q=201004;
    
    /// 服务条款
    static var TOS=202001;
    
    /// 用户协议
    static var USER_AGREEMENT=203001;
    
    static var CURRENT_MY_LOCATION = 0;
    
    /// 起始点
    static var START_PO=1;
    
    /// 停顿点
    static var STOP_PO=2;
    
    /// 结束点
    static var END_PO=3;
    
    /// 当前位置点
    static var CURRENT_PO=4;
    
    /// 报警2小时后位置
    static var EVENT_AFTER_2_HOURS_PO=5;
    
    /// 数据缺失类型
    static var DATA_LOST_PO=6;
    
    
    /// 异常移动
    static var MSG_MOVE=109
    
    /// 断电报警
    static var MSG_OUTAGE=110
    
    /// 天气提醒
    static var MSG_WEATER=108
    
    //小雨
    static var MSG_CATEGORY_WEATHER_XY=108001;
    //中雨
    static var MSG_CATEGORY_WEATHER_ZY=108002;
    //大雨
    static var MSG_CATEGORY_WEATHER_DY=108003;
    //暴雨
    static var MSG_CATEGORY_WEATHER_BY=108004;
    //大暴雨
    static var MSG_CATEGORY_WEATHER_DBY=108005;
    //特大暴雨
    static var MSG_CATEGORY_WEATHER_TDBY=108006;
    //霜冻
    static var MSG_CATEGORY_WEATHER_SD=108007;
    
    //大风5-6
    static var MSG_CATEGORY_WEATHER_DF56=108008;
    //大风7-8
    static var MSG_CATEGORY_WEATHER_DF78=108009;
    //大风8以上
    static var MSG_CATEGORY_WEATHER_DF8=108010;
    
    //污染指数150-200
    static var MSG_CATEGORY_WEATHER_WSZS152=108011;
    //污染指数200-300
    static var MSG_CATEGORY_WEATHER_WSZS23=108012;
    //污染指数300以上
    static var MSG_CATEGORY_WEATHER_WSZS300=108013;
    
    
    //小雪
    static var MSG_CATEGORY_WEATHER_XX=108014;
    //中雪
    static var MSG_CATEGORY_WEATHER_ZX=108015;
    //大雪
    static var MSG_CATEGORY_WEATHER_DX=108016;
    //暴雪
    static var MSG_CATEGORY_WEATHER_BX=108017;
    //大暴雪
    static var MSG_CATEGORY_WEATHER_DBX=108018;
    //特大暴雪
    static var MSG_CATEGORY_WEATHER_TDBX=108019;
    
    
    //电动车销售
    static var EBICK_GRANDE_FUNC_SALE=107001;
    //维修
    static var EBICK_GRANDE_FUNC_REPAIR=107002;
    //租车
    static var EBICK_GRANDE_FUNC_ZHU=107003;
    //改装
    static var EBICK_GRANDE_FUNC_GAI=107004;
    //充电
    static var EBICK_GRANDE_FUNC_CONG=107005;
    //销售乐行宝
    static var EBICK_GRANDE_FUNC_LEXING=107006;
    //上门
    static var EBICK_GRANDE_FUNC_GOTO=107007;
    
    
    
    
    /**
    * 异常移动类型
    */
    static var MSG_TYPE_MOVE=109;
    //普通异常移动消息
    static var MSG_CATEGORY_MOVE=109001;
    //ACC异常移动消息
    static var MSG_CATEGORY_ACC=109002;
    /**
    * 断电类型
    */
    static var MSG_TYPE_OUTAGE=110;
    //断电消息
    static var MSG_CATEGORY_OUTAGE=110001;
    
    
    
    
    
    
    /// 异常移动
    static var EVENT_MOVE=105001;
    
    /// 信号丢失
    static var EVENT_LOS=105002;
    
    /// 断电报警
    static var EVENT_OUTAGE=105003;
    
    /// WGS84坐标系统
    static var WGS84=0;
    
    /// GCJ02坐标系统
    static var GCJ02=1;
    
    /// bd09坐标系统
    static var BD09=2;
    
    /// 需要强制更新
    static var FORCE=1;
    
    /// 不需要强制更新
    static var UNFORCE=0;
    
    /// 弹出提示框
    static var PROMPT=1;
    
    /// 不需要弹出提示框
    static var NOPROMPT=0;
    
    /// 1表示安卓客户端
    static var ANDROID=1;
    static var IOS=2;
    
    /// 在线离线:1在线、0离线
    static var ONLINE=1;
    static var OFFLINE=0;
    
    /// ACC报警：1 是ACC报警/0 不是ACC报警
    static var ACC_EVENT=1;
    static var NOT_ACC_EVENT=0;
    
    //********  websocket and mq key ***************************
    static var   CLIENT_VERSION="CLIENT-VERSION";
    static var   CLIENT_ID="CLIENT-ID";
    
    static var   APPVERSION="appVersion";
    static var   EVENT="event";
    static var   ACCOUNT="account";
    static var   USER="user";
    static var   EBIKE="ebike";
    static var   PERIOD="period";
    static var   REALTIMETRAJECTOR="realtimeTrajector";
    static var   GENERAL="general";
    static var   HEARTBEAT="heartbeat";
    static var   ARMINGFLAG="armingFlag";
    static var   USERID="userId";
    static var   METHOD="method";
    static var   CONDITION="condition";
    static var   EBIKEID="ebikeId";
    static var   GPSID="gpsId";
    static var   GPS_STATUS="gpsStatus";
    static var   GPS_CONN="gpsConn";
    static var   GPS_UNCONN="gpsUnconn";
    
    /**
    * 服务器运行状态
    * @author yuwenhao
    * desction:
    *   状态码：20502
    2	                      05	          02
		  服务级代码（1为系统级代码）	           服务模块代码	   具体代码
    */
    struct SystemSC{
        
        /// 系统成功执行
        static var SYSTEM_OK = 10001;
        
        /// 系统错误
        static var SYSTEM_ERROR = 10002;
        
        /// 系统暂停
        static var SYSTEM_PAUSE = 10003;
        
        ///  系统未知错误(数据库未知错误)
        static var SYSTEM_UNKOWN_ERROR = 10004;
    }
    
    struct CommonSC {
        
        /// 无数据
        static var NO_DATA = 20001;
        
        /// 参数错误
        static var PARAM_ERROR = 20002;
        
        /// 分页参数错误
        static var PAGING_PARAM_ERROR = 20003;
    }
    
    struct UserSC {
        
        /// 找不到对应的用户  = 比20102更抽象,包含两层意思，1.用户不存在 2.指定条件找不到用户)
        static var NOT_FOUND_USER = 20101;
        
        /// 用户不存在
        static var ACCOUNT_NOT_EXIST = 20102;
        
        /// 手机号已注册
        static var PHONE_EXISTS = 20103;
        
        /// 手机号不合法
        static var PHONE_ILLEGAL = 20104;
        
        /// 密码错误
        static var PASSWORD_ERROR = 20105;
        
        /// 用户权限不够
        static var PERMISSION_NOT_ENOUGH = 20106;
        
        /// 没有发送验证码
        static var NO_VALIDATE = 20107;
        
        /// 验证码已失效
        static var VALIDATE_FIAL = 20108;
        
        /// 验证码错误
        static var VALIDATE_ERROR = 20109;
        
        /// 找不到文件 = 1.app
        static var NOT_FOUND_FILE = 20110;
        
        /// 验证码短信已达上限
        static var VALIDATE_CODE_SMS_UPPER_LIMIT = 20111;
        
        /// 新密码和旧密码一样
        static var NEW_OLD_PASSWORD_SAME = 20112;
        
        /// 用户已绑定微信
        static var USER_ALREADY_BIND_WEIXIN = 20113;
    }
    
    struct GpsSC{
        
        /// 找不到对应的GPS
        static var NOT_FOUND_GPS = 20201;
        
        /// GPS不存在
        static var GPS_NOT_EXIST = 20202;
        
        /// GPS已被自己绑定
        static var GPS_ALREADY_SELF_BIND = 20203;
        
        /// GPS已被他人绑定
        static var GPS_ALREADY_OTHERS_BIND = 20204;
    }
    
    struct EbikeSC{
        
        /// 找不到对应的ebike
        static var NOT_FOUND_EBIKE = 20301;
        
        /// ebike不存在
        static var EBIKE_NOT_EXIST = 20302;
        
        /// 电动车已存在
        static var EBIKE_ALREADY_EXISTS = 20303;
        
        /// 无电动车数据
        static var NO_EBIKE_DATA = 20304;
        
        /// 电动车未绑定GPS设备
        static var EBIKE_NO_BIND = 20305;
        
        /// 存在多辆电动车
        static var EXIST_MANY_EBIKE = 20306;
    }
    
    struct EbikeEventPeriod{
        /// 找不到对应的EbikeEventPeriod
        static var NOT_FOUND_EBIKE_EVENT_PERIOD = 20401;
        
        /// EbikeEventPeriod不存在
        static var EBIKE_EVENT_PERIOD_NOT_EXIST = 20402;
        
        /// 免打扰区间daysInWeek设置错误
        static var EBIKE_EVENT_PERIOD_DAYS_IN_WEEK_ERROR = 20403;
    }
    
    struct EbikeEvent {
        
        /// 找不到对应的EbikeEvent
        static var NOT_FOUND_EBIKE_EVENT = 20501;
        
        /// EbikeEvent不存在
        static var EBIKE_EVENT_NOT_EXIST = 20502;
    }
    
    struct HistoryEbikeLocation {
        
        /// 找不到对应的轨迹
        static var NOT_FOUND_HIS_EBIKE_LOC = 20601;
        
        /// 轨迹不存在
        static var HIS_EBIKE_LOC_NOT_EXIST = 20602;
        
        /// 时间参数错误
        static var TIME_PARAM_ERROR = 20603;
    }
    
    struct FeedbackSC {
        
        /// 找不到对应的FeedBack
        static var NOT_FOUND_FEEDBACK = 20801;
        
        /// FeedBack不存在
        static var FEEDBACK_NOT_EXIST = 20802;
    }
    
    struct ActionSheetSC {
        static var LOGINOUT = 100
        static var TEL = 101
    }
    
    struct SMSSC {
        
        /// 请求参数缺失 1
        static var REQ_PARAM_LOST = 20901;
        
        /// 请求参数格式错误 2
        static var PARAM_FORMAT_ERR = 20902;
        
        /// 账户余额不足 3
        static var LACK_OF_BALANCE = 20903;
        
        /// 关键词屏蔽 4
        static var KEYWORD_SHIELDING = 20904;
        
        /// 未找到对应id的模板 5
        static var NOT_FOUND_TPL_OF_ID = 20905;
        
        /// 模板不可用7
        static var TPL_NOT_USE = 20907;
        
        /// 同一手机号30秒内重复提交相同的内容 8
        static var REPEAT_SAME_PHONE_NO_30_SECONDS_SEND_SAME_CONTENT = 20908;
        
        /// 同一手机号5分钟内重复提交相同的内容超过3次 9
        static var REPEAT_SAME_PHONE_NO_5_MINUTES_SEND_MORE_THAN_3_TIMES_SAME_CONTENT = 20909;
        
        /// 手机号黑名单过滤 10
        static var PHONE_NO_LIST_FILTERING = 20910;
        
        /// 营销短信暂停发送 13
        static var PAUSE_SEND_MARKETING_MSG = 20913;
        
        /// 解码失败 14
        static var DECODING_FAILURE = 20914;
        
        /// 签名不匹配 15
        static var SIGNATURE_DOES_NOT_MATCH = 20915;
        
        
        /// 签名格式不正确 16
        static var SIGNATURE_FORMAT_IS_NOT_CORRECT = 20916;
        
        /// 24小时内同一手机号发送次数超过限制 17
        static var SAME_PHONE_NO_SEND_IN_24_HOURS_MORE_THAN_LIMIT = 20917;
        
        /// 非法的apikey -1
        static var ILLEGAL_APIKEY = 20918;
        
        /// API没有权限 -2
        static var API_WITHOUT_PERMISSION = 20919;
        
        /// IP没有权限 -3
        static var IP_WITHOUT_PERMISSION = 20920;
        
        /// 访问次数超限 -4
        static var VISITED_TRANSFINITE = 20921;
        
        /// 访问频率超限 -5
        static var ACCESS_FREQUENCY_TRANSFINITE = 20922;
        
        /// 未知异常 -50
        static var UNKNOWN_ABNORMAL = 20967;
        
        
        /// 系统繁忙 -51
        static var SYSTEM_BUSY = 20968;
        
        /// 提交短信失败 -53
        static var SUBMIT_SMS_FAILURE = 20970;
        
        /// 用户开通过固定签名功能，但签名未设置 -57
        static var USERS_OPEN_FIXED_SIGNATURE_BUT_SIGNATURE_NOT_SET = 20974;
        
        /// 其它错误
        static var OTHER_ERROR = 20998;
        
        /// 短信发送错误 = 本服务内部错误
        static var SMS_ERROR = 20999;
    }
    
    struct DictionarySC {
        
        /// 找不到对应的 dictionary
        static var NOT_FOUND_DICTIONARY = 21001;
    }
    
    struct GeneralSC {
        
        /// 找不到对应的子分类
        static var NOT_FOUND_CATEGORY = 21101;
        
        /// 子分类不存在
        static var CATEGORY_NOT_EXIST = 21102;
        
        /// 无内容
        static var NO_CONTENT = 21103;
    }
    
    struct ConfigSC {
        
        /// 找不到对应的配置信息
        static var NOT_FOUND_CONFIG = 21201;
        
        /// 配置信息不存在
        static var CONFIG_NOT_EXIST = 21202;
    }
    
    struct PushMsgSC {
        
        /// 找不到对应的推送信息
        static var NOT_FOUND_PUTSH_MSG = 21301;
        
        /// 推送信息不存在
        static var PUTSH_MSG_NOT_EXIST = 21302;
    }
    
    struct ClientInfoSC {
        
        /// 找不到对应的客户端信息
        static var NOT_FOUND_CLIENT_INFO = 21401;
        
        /// 客户端信息不存在
        static var CLIENT_INFO_NOT_EXIST = 21402;
        
        /// 客户端信息已存在
        static var CLIENT_INFO_EXIST = 21403;
    }
    
    struct DrivingRecordSC {
        
        /// 找不到对应的行驶记录
        static var NOT_DRIVING_RECORD = 21501;
        
        /// 行驶记录不存在
        static var DRIVING_RECORD_NOT_EXIST = 21502;
    }
    
    struct DrivingRecordStatusSC {
        
        /// 找不到对应的行驶记录状态
        static var NOT_DRIVING_RECORD_STATUS = 21601;
        
        /// 行驶记录状态不存在
        static var DRIVING_RECORD_STATUS_NOT_EXIST = 21602;
    }
    
    
    /**
    *  常用键值对
    */
    struct KEY {
        static var PLAT_REPONSE_STATUS = "status";
        static var PLAT_REPONSE_DATA = "data";
        static var LEXING_KEY = "LEXING-KEY";
        static var DEVICE_TOKEN = "DEVICE-TOKEN";
        static var LEXING_STATUS = "LEXING-STATUS";
        static var CONTENT_TYPE="Content-Type";
        static var APPLICATION_JSON="application/json";
        static var LEXING_BODY_DATA = "LEXING-BODY-DATA";
    }
    
    
    /**
    *  用户请求地址
    */
    struct URL {
        
        // ------------------------------------user请求url定义开始-----------------------------------------
        
        /// 用户信息
        static var USER = "/user.json";
        
        
        /// 设备唯一标识
        static var DEVICE_UUID = "/device/identifier.json"
        
        /// 验证码判断
        static var USER_VALIDATE = "/validatecode/phone/check.json";
        
        /// 用户注册验证码请求
        static var USER_REGISTER_VALIDATE = "/user/register/validation.json";
        
        /// 用户注册请求
        static var USER_REGISTER = "/user/register.json";
        
        /// 获取最新客户端版本号
        static var USER_CLIENT_VERSION = "/user/client/version/{version}.json";
        static var F_USER_CLIENT_VERSION = "/user/client/version/{0}.json";
        
        
        /// 根据id  [1.获取用户信息	   ]
        static var USER_ID = "/user/{id}.json";
        static var F_USER_ID = "/user/{0}.json";
        
        /// 登录
        static var USER_LOGIN = "/user/login.json";
        
        static var USER_LOGIN_OUT = "/user/logout.json";
        
        /// 找回密码之发送验证码
        static var USER_PASSWORD_FORGOT_VALIDATE = "/user/password/forgot/validation/{patternVal}.json";
        static var F_USER_PASSWORD_FOTGOT_VALIDATE = "/user/password/forgot/validation/{0}.json";
        
        /// 找回密码之修改密码
        static var USER_PASSWORD_FOTGOT = "/user/password/forgot.json";
        
        /// 修改密码
        static var USER_PASSWORD = "/user/password.json";
        
        /// 心跳
        static var USER_HEARTBEAT = "/user/heartbeat/{userId}.json";
        static var F_USER_HEARTBEAT = "/user/heartbeat/{0}.json";
        
        
        /// 客户端标识
        static var USER_CLIENT_ID = "/user/client/id.json";
        //-------------------------------------- GPS请求url定义开始------------------------------------------
        
        /// 修改gps信息
        static var GPS = "/gps.json";
        
        /// 获取gps信息，根据id
        static var GPS_ID = "/gps/{gpsId}.json";
        static var F_GPS_ID = "/gps/{0}.json?coord_type=2";
        
        /// 设置gps布防
        static var GPS_ARMING = "/gps/arming.json";
        
        /// 根据gps ids获取gps布防状态
        static var GPS_ARMING_GPS_IDS = "/gps/arming/{userId}/{gpsIds}/state.json";
        static var F_GPS_ARMING_GPS_IDS = "/gps/arming/{0}/{1}/state.json";
        
        /// GPS二维码绑定电动车
        static var GPS_QRCODE = "/gps/qrcode.json";
        
        static var GPS_QRCODE_V2 = "/gps/qrcode/{qrCode}";
        static var F_GPS_QRCODE_V2 = "/gps/qrcode/{0}.json";
        
        static var BIND_GPS_IMEI = "/gps/bind/imei";
        static var F_BIND_GPS_IMEI = "/gps/bind/imei.json";
        
        static var BIND_GPS_LEXING_CODE = "/gps/bind/lexingcode";
        static var F_BIND_GPS_LEXING_CODE = "/gps/bind/lexingcode.json";
        
        /// GPS数据
        static var GPS_DATA = "/gps/data.json";
        // ------------------------------------ebike请求url定义开始-----------------------------------------
        
        /// 获取品牌信息
        static var EBICK_BRAND = "/ebike/brand.json"
        
        /// 获取广告
        static var EBICK_ADVERT = "/advert.json?position=1"
        
        /// 添加修车铺
        static var EBICK_ADD = "/businesses.json"
        
        
        /// 获取添加的修车铺信息
        static var MINE_EBICK_BANDER_ADD = "/businesses/mark.json?coord_type=2"
        
        /// 删除修车铺
        static var MINE_EBICK_BANDER_DELETE = "/businesses/{0}.json"
        
        /// 电动车数量
        static var EBICK_COUNT = "/businesses/count.json"
        
        
        /// 电动车信息
        static var EBIKE = "/ebike.json";
        
        /// 根据用户id [1.获取电动车信息]
        static var EBIKE_USER_ID = "/ebike/{userId}.json";
        static var F_EBIKE_USER_ID = "/ebike/{0}.json?coord_type=2";
        
        /// 根据用户id [1.获取电动车实时数据信息]
        static var EBIKE_DATA_USER_ID = "/ebike/data/{userId}.json";
        static var F_EBIKE_DATA_USER_ID = "/ebike/data/{0}.json?&coord_type=2";
        static var F_EBIKE_DATA_USER_ID_VERSION = "/ebike/data/{0}.json?version={1}&coord_type=2";
        
        /// 根据电动车id [1.获取电动车信息 /n 2.逻辑删除电动车信息]
        static var EBIKE_ID = "/ebike/{userId}/{ebikeId}.json";
        static var F_EBIKE_ID = "/ebike/{0}/{1}.json?coord_type=2";
        
        
        static var EBIKE_UNCONN = "/ebike/{ebikeId}/unconn/gps";
        static var F_EBIKE_UNCONN = "/ebike/{0}/unconn/gps.json";
        // ------------------------------------ebikeEventPeriod请求url定义开始-----------------------------------------
        static var EBIKE_PERIOD = "/ebike/period.json";
        
        /// 根据ebikeId [ 1.获取电动车监控时间 ]
        static var EBIKE_PERIOD_EBIKE_ID = "/ebike/period/{userId}/ebike/{ebikeId}.json";
        static var F_EBIKE_PERIOD_EBIKE_ID = "/ebike/period/{0}/ebike/{1}.json";
        
        /// 根据periodId [1.获取电动车监控时间 /n 2.删除电动车监控时间]
        static var EBIKE_PERIOD_PERIOD_ID = "/ebike/period/{userId}/{periodId}.json";
        static var F_EBIKE_PERIOD_PERIOD_ID = "/ebike/period/{0}/{1}.json";
        // ------------------------------------电动车事件请求url定义开始-----------------------------------------
        
        ///  事件信息
        static var EBIKE_EVENT = "/ebike/event.json";
        
        ///  根据用户id [1.统计电动车报警信息]
        static var EBIKE_EVENT_COUNT_USR_ID = "/ebike/event/count/{userId}.json";
        static var F_EBIKE_EVENT_COUNT_USR_ID = "/ebike/event/count/{0}.json";
        
        static var F_ALL_EBIKE_EVENT_COUNT = "/ebike/event/statistics.json";
        
        
        /// Acc 检测
        static var F_GPS_ACC = "/gps/{0}/acc/detection/{1}.json"
        
        
        ///  根据用户id [1.获取电动车报警信息 \n 2.删除用户所有电动车报警]
        static var EBIKE_EVENT_USR_ID = "/ebike/event/{userId}.json";
        static var F_EBIKE_EVENT_USR_ID = "/ebike/event/{0}.json";
        
        static var F_EBIKE_EVENT_CATEGORY = "/ebike/event/ebike/{0}/category/{1}.json?coord_type=2&&paged={2}&pageSize={3}";
        static var F_EBIKE_DELETE_EVENT_CATEGORY = "/ebike/event/{0}/category/{1}.json";
        
        static var F_EBIKE_READ_EVENT_CATEGORY = "/ebike/event/{0}/category/{1}/read.json"
        
        
        /// 根据用户id,起始时间 [1.获取电动车报警信息]
        static var EBIKE_EVENT_DATA_USR_ID = "/ebike/event/data/{userId}.json";
        static var F_EBIKE_EVENT_DATA_USR_ID =  "/ebike/event/data/{0}.json&coord_type=2";
        static var F_EBIKE_EVENT_DATA_USR_ID_VERSION =  "/ebike/event/data/{0}.json?version={1}&coord_type=2";
        
        /// 根据用户id,readFlag [1.获取电动车报警通知]
        static var EBIKE_EVENT_NOTICE = "/ebike/event/{userId}/notice.json";
        static var F_EBIKE_EVENT_NOTICE =  "/ebike/event/{0}/notice.json";
        
        
        /// 根据报警id[1.删除报警]
        static var EBIKE_EVENT_ID = "/ebike/event/{userId}/{eventId}.json";
        static var F_EBIKE_EVENT_ID = "/ebike/event/{0}/{1}.json";
        
        /// 电动车报警标记为已读,根据id
        static var EBIKE_EVENT_READ = "/ebike/event/{userId}/{eventId}/read.json";
        static var F_EBIKE_EVENT_READ = "/ebike/event/{0}/{1}/read.json";
        
        
        
        
        /// 同步账号
        static var DEVICE_USER_SYNC = "/visitor/sync.json"
        
        
        /// 删除某条消息
        static var MSG_DELETE = "/msg/type/{0}/{1}.json"
        
        /// 删除用户某类消息
        static var MSG_DELETE_BY_TYPE = "/msg/type/{0}.json"
        
        /// 阅读某类型消息
        static var MSG_READ = "/msg/type/{0}/read.json"
        
        /// 获取用户某类型消息
        static var MSG_GET_BY_TYPE = "/msg/type/{0}.json?paged={1}&pageSize={2}"
        
        /// 获取用户最近消息统计信息
        static var MSG_COUNT = "/msg/statistics.json"
        
        // ------------------------------------historyEbikeLocation url定义开始-----------------------------------------
        
        /// 电动车轨迹信息
        static var HIS_EBIKE_LOCATION = "/his/ebike/location.json";
        
        /// 根据ebikeId [1.获取电动车轨迹]
        static var HIS_EBIKE_LOCATION_EBIKEID = "/his/ebike/location/{userId}/{ebikeId}/{startTime}/{endTime}.json";
        //		static var F_HIS_EBIKE_LOCATION_EBIKEID = "/his/ebike/location/{0}/{1}/{2}/{3}.json";
        
        
        /// 根据ebikeId[1.获取电动车实时轨迹]
        static var TRAJECTORY_REALTIME_EBIKEID = "/trajectory/realtime/{userId}/ebike/{ebikeId}.json";
        static var F_TRAJECTORY_REALTIME_EBIKEID = "/trajectory/realtime/{0}/ebike/{1}.json";
        static var F_TRAJECTORY_REALTIME_EBIKEID_VERSION = "/trajectory/realtime/{0}/ebike/{1}.json?coord_type=2";
        
        /// 报警轨迹
        static var TRAJECTORY_EVENT_EBIKEID_EVENTID = "/trajectory/event/{userId}/ebike/{ebikeId}/event/{eventId}.json";
        static var F_TRAJECTORY_EVENT_EBIKEID_EVENTID = "/trajectory/event/{0}/ebike/{1}/event/{2}.json?coord_type=2";
        
        
        /// 行驶记录
        static var TRAJECTORY_RECORD = "/trajectory/record/ebike/{ebikeId}/start/{startTime}/end/{endTime}";
        static var F_TRAJECTORY_RECORD = "/trajectory/record/ebike/{0}/start/{1}/end/{2}.json?coord_type=2";
        
        
        /// 轨迹点
        static var TRAJECTORY_POINT = "/trajectory/ebike/{ebikeId}/start/{startTime}/end/{endTime}";
        static var F_TRAJECTORY_POINT = "/trajectory/ebike/{0}/start/{1}/end/{2}.json?coord_type=2";
        
        /// 行驶记录状态
        static var TRAJECTORY_RECORD_STATUS = "/trajectory/record/status/ebike/{ebikeId}/date/{date}";
        static var F_TRAJECTORY_RECORD_STATUS = "/trajectory/record/status/ebike/{0}/date/{1}.json";
        
        //------------------------------------Businesses请求url定义开始-----------------------------------------
        
        /// 商户信息
        static var BUSINESSES = "/businesses";
        static var F_BUSINESSES = "/businesses.json?coord_type=2";
        
        // 城市商户信息数量
        static var BUSINESSESCOUNT = "/businesses/count.json?city={0}&sort=1&source=1"
        
        //------------------------------------feedback请求url定义开始-----------------------------------------
        
        /// 意见反馈信息
        static var FEEDBACK = "/feedback.json";
        
        
        /// 用户位置信息
        static var USER_LOCATION_UPLOAD = "/user/location.json"
        
        /// 根据userId [1.获取feedback信息]
        static var FEEDBACK_USERID = "/feedback/{userId}.json";
        static var F_FEEDBACK_USERID = "/feedback/{0}.json";
        
        //------------------------------------generalInfo请求url定义开始-----------------------------------------
        /// 一般信息
        static var GENERAL = "/general";
        static var GENERAL_CATEGORY_INFO = "/general/category.json";
        
        /// 根据type[1.获取小分类信息 ]
        static var GENERAL_TYPE = "/general/type/{type}.json";
        static var F_GENERAL_TYPE = "/general/type/{0}.json";
        
        
        /// 根据category[1.获取内容 ]
        static var GENERAL_CATEGORY = "/general/category/{category}.json";
        static var F_GENERAL_CATEGORY = "/general/category/{0}.json";
        static var F_GENERAL_CATEGORY_VERSION = "/general/category/{0}.json?version={1}";
        
        //**************************************** config  信息请求url 定义开始********************************************
        /// 配置信息[1.修改]
        static var CONFIG = "/config.json";
        
        //************************************** refresh 请求url 定义开始
        static var REFRESH_SYSTEM_DICTIONARY="/refresh/systemDictionary";
        static var REFRESH_USER="/refresh/user";
        static var REFRESH_CONFIG="/refresh/config";
        static var REFRESH_GPS="/refresh/gps";
        
        
        //**************************************** 其它 信息请求url 定义开始********************************************
        static var LOAD_DATA_AFTER_LOGIN = "/load/data/after/login/{userId}.json";
        static var F_LOAD_DATA_AFTER_LOGIN = "/load/data/after/login/{0}.json?coord_type=2";
        
        static var DATA_CHANGE_CHECK="/data/change/check/{userId}.json";
        static var F_DATA_CHANGE_CHECK="/data/change/check/{0}.json?coord_type=2";
        
        
        
        //---------------------- 支付--------------------------------------------------
        
        static var F_ORDER_ALIPAY = "/pay/alipay/unifiedorder.json"
        static var F_ORDER_WXPAY = "/pay/wx/unifiedorder.json"
        
        
        
        
        //---------------------- 微信请求url定义开始--------------------------------------------------
        static var WEIXIN_USER = "/weixin/user/bind";
        static var F_WEIXIN_USER = "/weixin/user/bind.json";
        
        static var WEIXIN_USER_REGISTER = "/weixin/user/register";
        static var F_WEIXIN_USER_REGISTER = "/weixin/user/register.json";
        
        static var WEIXIN_USER_OPENID = "/weixin/user/openid/{openid}";
        static var F_WEIXIN_USER_OPENID = "/weixin/user/openid/{0}.json";
        
        
    }
}

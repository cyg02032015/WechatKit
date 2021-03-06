//
//  WechatManagerAuthDelegate.swift
//  WechatKit
//
//  Created by starboychina on 2015/12/03.
//  Copyright © 2015年 starboychina. All rights reserved.
//
/**
*  Auth
*/
public protocol WechatManagerAuthDelegate {
    /**
     如果需要服务器端再次认证时设置该方法
     (服务器端认证WechatManager.openid 及WechatManager.accesstoken,并根据WechatManager.openid取得自己系统的用户信息)
     
     - parameter completion: 如果被调用,则返回继续执行认证处理
     当res(自己系统的用户信息)不为空时,直接调用 success
     当 errCode 为401时, 则重新回去accesstoken, 获取成功 则直接调用 success
     当 errCode 为404时, 则去获取微信的用户基本信息, 并调用 signupIfNeeded
     
     - returns: 是否要再次获取微信用户信息
     如果实现了该方法, 需要return true;
     如果return false; 除上述调用success以外,还会在执行一次success(微信用户基本信息)
     */
    func checkIfNeeded(completion: ((res: AnyObject?, errCode: Int?) -> ())) -> Bool
    /**
     如果用户在你的系统中不存在, 并希望能实现自动注册时,通过该方法实现 * 需要实现checkIfNeeded
     
     - parameter parameters: 从微信取得的用户的基本信息
     - parameter completion: 如果被调用,则返回继续执行 success(res)
     */
    func signupIfNeeded(parameters: [String : AnyObject], completion: ((res: AnyObject) -> ()))
    /**
     认证成功时调用
     
     - parameter res:
     如果实现了checkIfNeeded 并且服务器认证成功时,返回 系统用户信息,认证失败401时,返回新的access_token及refresh_token
     如果没有实现checkIfNeeded ,则返回 微信用户的基本信息
     */
    func success(res: AnyObject)
    /**
     认证失败
     
     - parameter errCode: 返回认证错误码
     详见 https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=open1419318634&token=&lang=zh_CN
     
     */
    func failure(errCode: Int)
}

extension WechatManagerAuthDelegate {
    /**
     Default Implementation
     
     - parameter completion: completion description
     
     - returns: false
     */
    public func checkIfNeeded(completion: ((res: AnyObject?, errCode:Int?) -> ())) -> Bool {
        print("openid: \(WechatManager.openid) access_token: \(WechatManager.access_token)")
        return false
    }
    /**
     Default Implementation
     
     - parameter parameters: parameters
     - parameter completion: completion
     */
    public func signupIfNeeded(parameters: [String : AnyObject], completion: ((res: AnyObject) -> ())) { print(parameters) }
}

# NCUFriend聊天室

## 一.所用技术
项目使用Maven构建,后台使用的语言是JAVA

框架为Spring + Spring MVC + Mybatis

数据库使用的是MySQL
前端采用[Amaze UI](http://amazeui.org/),弹窗和分页使用的是[Layer](www.layui.com),当然还有[Jquery](http://jquery.com/)...

开发工具使用的是[IDEA](http://www.jetbrains.com/idea/)

## 二.数据交互格式
在WebChat中定义的前后台数据交换格式如下:
```
"message" : {
	"from" : "xxx",
	"to" : "xxx",
	"content" : "xxxxxx",
	"time" : "xxxx.xx.xx"
},
"type" : {
	"xxx"
},
"list" : {
	["xx","xx"]
}
```
其中,message是消息部分,from是发信人用户名,to是收信人用户名(如果是群聊则置空),content是消息内容,time是发送时间,这里发信时间是前台JS获取,from和to都是直接用用户名而不是昵称....都是为了偷懒

type是消息类型,分为两种,notice和message.notice是提示类型,比如xxx用户加入了聊天室,xxx用户离开了聊天室;message是消息类型,就是用户之间发送的消息

list是当前在线的用户名的列表,只在后台触发onopen和onclose时返回list,然后更新前台的在线列表,实现实时的列表展示

## 三.实现功能
用户登录注册注销,用户信息展示,用户信息修改,用户头像修改,修改密码,在线聊天,在线列表展示,好友资料卡,日志记录展示，聊天记录查看下载删除，好友印象管理，添加删除好友发送验证消息，迷你资料卡，添加删除修改好友印象。

## 五.GIT Commit 规范
#### type
* type is used to explain the category of commit,only contain :
 * `feat`:feature
 * `fix`:repair bug
 * docs:documentation
 * `style`:style (no code change)
 * `refactor`:restructure
 * `test`:increase the test
 * `chore`:change in the construction or anxiliary tools
* if type is feat or fix,and this commit must be in Change log.the others are recommended not to increase.
* 例子：fix:repairing the bug of Mini Data Card


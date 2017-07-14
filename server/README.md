
## 金山云短视频鉴权说明

### 1. APP Server端

App需要获取短视频SDK鉴权信息，在向App Server请求鉴权信息时，需要携带当前应用的包名Pkg：

`curl 'http://ksvs-demo.ks-live.com:8321/Auth?Pkg=aa'`

返回:

```
{
  "Data": {
    "Authorization": "AWS4-HMAC-SHA256 Credential=AKLTCWyerkzTRvSRgBjCSzPsXQ/20170414/cn-beijing-6/ksvs/aws4_request, SignedHeaders=host;x-amz-date, Signature=742b927f176d43de5aada2f344d15cecfccacd73284151d6d1d5cfdaf9ac583f",
    "RetCode": 0,
    "RetMsg": "success",
    "x-amz-date": "20170414T091747Z"
  }
}
```
RetCode: 0 表示正常


以上流程示范是我们当前APP DEMO流程，开发者需要模仿以上请求并返回如下字段：
* Authorization
* x-amz-date

> 如果只想评估短视频SDK，可以首先使用 http://ksvs-demo.ks-live.com:8321/Auth?Pkg=aa 进行评估。

**上线前需要将 http://ksvs-demo.ks-live.com:8321/Auth?Pkg=aa 服务替换成开发者自己的服务接口，不然造成的短视频功能异常，金山云不承担任何责任**

### 2. 测试
当开发者完成了 http://ksvs-demo.ks-live.com:8321/Auth?Pkg=aa 服务的替换，使用自己的ak/sk进行鉴权了。需要测试返回的字段是否正常：
* Authorization
* x-amz-date


用APP SERVER返回的Authorization, x-amz-date 构造header，注意更改Pkg 为当前应用的包名。比如之前测试使用的**aa**

```
curl https://ksvs.cn-beijing-6.api.ksyun.com\?Action\=KSDKAuth\&Version\=2017-04-01\&Pkg\=aa -H 'x-amz-date: 20170414T090741Z' -H 'Authorization:AWS4-HMAC-SHA256 Credential=AKLTCWyerkzTRvSRgBjCSzPsXQ/20170414/cn-beijing-6/ksvs/aws4_request, SignedHeaders=host;x-amz-date, Signature=ab9f5676951b9938e754d340af5eff28e1e5a0e0ee2e2c7e7424eba34915e236'
```

返回：
```
{
  "Data": {
    "RetCode": 0,
    "RetMsg": "success"
  },
  "RequestId": "2548c8fd-303a-415f-af25-00f12acb682f"
}
```

表示鉴权成功

> 如果鉴权成功，恭喜你，你的鉴权服务搭建完成。

### 3. 反馈
当前提供了三种服务器auth代码：
* [php](php/auth)
* [java](java/auth)
* [python](python/auth)

如果代码集成到server过程中遇到问题，可以以下两个渠道获取帮助：
* QQ讨论群：574179720 [视频云技术交流群] 
* Issues:<https://github.com/ksvc/KSYMediaEditorKit_iOS/issues>

我们推荐大家提issues，这样方便其他开发者在遇到问题时通过已解决的issues中快速获取解决方案。

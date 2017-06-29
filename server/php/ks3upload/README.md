# 文件说明

* php文件为laravel框架的实现文件
* api.php为路由文件
* UploadController.php为具体实现
* GetKs3Signature为获取签名,获取签名后向ks3进行文件上传
* GetKs3SignedUrl为获得加密的文件url
* config('ks.ak') 为您的ak
* config('ks.sk') 为您的sk
* config('ks.bucket') 为您的bucket



# 接口



## 获得待上传ks3的签名信息(GetKs3Signature)
-----------------------


### 请求

| url | method |
| --- | --- |
| api/upload/ks3/sig | GET |


| param | type | 是否必须 | 举例 |
| --- | ---  | --- | --- |
| verb | string | ✅  | get, post , eta.. |
| md5 | string | ✅ | md5 |
| type | string | ✅ | content type |
| res | string | ✅ | resource |
| headers | string | ✅ | http headers |
| date | string | X | 时间，如果端没传，则使用server的 |


### 应答

| key | type | 是否必须 | 举例 |
| --- | --- | --- | --- |
| errno| int | ✅ |0:ok 其他：见错误表|
| errmsg | string |  ✅ | "" |
| Date | string | ✅| date |
| Authorization | string | ✅  | 最终验证参数sig|


## 获得加密的ks3文件url(GetKs3SignedUrl)
-----------------------


### 请求

| url | method |
| --- | --- |
| api/upload/ks3/signurl | GET |


| param | type | 是否必须 | 举例 |
| --- | ---  | --- | --- |
| objkey | string | ✅  | 文件路径 |


### 应答

| key | type | 是否必须 | 举例 |
| --- | --- | --- | --- |
| errno| int | ✅ |0:ok 其他：见错误表|
| errmsg | string |  ✅ | "" |
| presigned_url | string | ✅  | 加密的url |


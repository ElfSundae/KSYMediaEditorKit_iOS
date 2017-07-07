
# 鉴权


app第一次获取鉴权信息接口，输入Pkg：

`curl 'ksvs-demo.ks-live.com:8321/Auth?Pkg=aa'`

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

app然后进行第二部，用刚才得到的Authorization, x-amz-date 构造header，注意更改Pkg

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

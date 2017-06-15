# 使用说明

* 本代码只说明了如何产生鉴权server产生的两个header:`X-Amz-Date`和`Authorization`
* php 5.6.26 环境下测试通过


# 使用方法

* 修改setting.php里面的ak,sk为您在金山云的ak,sk
* 修改setting.php 里面的pkg 为您的package name
* php gen_headers.php 获得产生的header:`X-Amz-Date`和`Authorization`
* 搭建php server
* 调用您搭建php server的接口返回相应的鉴权用header信息

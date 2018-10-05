# CountryPicker
国家和地区区号选择

![](https://github.com/biloba123/CountryPicker/blob/master/ScreenShot/list.png)

使用方法
```
[CPCountryTableViewController pickWithViewController:self callback:^(CPCountry *country) {
        //选择地区后的回调
        //获得区号
        //country.code
    }];
```

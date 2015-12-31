# pry-translator 

## Install

`gem install pry-translator`


## Configure  

open ~/.pryrc file, and add following snippet.
    
    # for youdao translator configure
    Pry.config.translator = :youdao
    Pry.config.translator_keyfrom = KEYFROM
    Pry.config.translator_key = KEY

    # for baidu translator configure
    Pry.config.translator = :baidu
    Pry.config.translator_appid = APPID
    Pry.config.translator_appsecret = APPSECRET
    
## Usage
  
    [1] pry(main)> t apple
    苹果
    [2] pry(main)> t how are you?
    你好吗？
    
## Other
有空改一下，支持语言方向和持支持google

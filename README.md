# nvim-config

个人 nvim0.6 配置文件。

你需要创建一个 `plugged` 目录来存放下载的插件。

在 `settings/1plugged.vim` 文件中，我对来自 github 的插件下载地址都添加了镜像地址前缀，所以你可以看见
`Proxy 'user/repo'` 形式的安装命令。

在 `init.vim` 中，我已经设置 `settings` 目录下的 `.vim` 脚本都是配置脚本，但要注意读取的顺序。

# 用Docker打造Golang开发环境

​        基于Golang官方Alpine版Docker镜像，来构建Golang的开发环境，官方的镜像的Golang版本为15.4。

​       为了能够开箱即用，同时安装了git、zsh、vim等工具

​       然后通过vsc的remote-containers插件连接容器的golang开发环境进行开发。

### Quick Start

#### 1、构建镜像

```
$ docker build -t tonywell/golangdev .
```

安装oh-my-zsh

```
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
```



#### 2、启动容器

```
$ docker-compose up -d
```

说明：

* 需要安装docker-compose，自行安装

* 容器的时间设置为上海

  ```
  environment:
     TZ: Asia/Shanghai
  ```

* 为了使容器不退出，坐如下配置

  ```
  stdin_open: true
  tty: true
  privileged: true
  ```

#### 3、安装golang/x/tools

为了vsc连接golangdev环境，能够支持自动完成，自动导入，代码导航等功能，我们需要安装golang/x/tools，因为一些特殊原因，go get无法安装tools，所以我们需要通过github上的镜像来安装。

首先进入容器

```
$ docker exec -it golang_golang_1 zsh
```

进入容器后执行下列命令

```
$ mkdir -p $GOPATH/src/golang.org/x
$ cd $GOPATH/src/golang.org/x
$ git clone https://github.com/golang/tools.git
$ go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
$ go get -u -v github.com/go-delve/delve/cmd/dlv
$ go get -u -v github.com/stamblerre/gocode
$ go get -u -v github.com/rogpeppe/godef
$ git clone https://github.com/golang/lint.git
```

#### 4、VSC连接容器

* 首先VSC需要安装Remote-Containers插件
* 在vscode中按F1，输入Remote-Containers: Open，按照提示选择 Open Attched to running Container ……，VSC会自动识别出容器，选择正在运行的angulardev容器
* vsc会提示安装相关内容
* 接下来就可以通过VSC在golangdev容器中愉快的开发了。
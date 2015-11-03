1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

安装、配置并管理mcollective

## Module Description

```
由于一些众所周知的原因，无法直接获取puppet包，因此，笔者直接下载依赖包到本地，
使用puppet直接下发到agent，此模块下发的mcollective的来源如下：
debian: https://apt.puppetlabs.com/
redhat: https://yum.puppetlabs.com/
```

## Usage

例： 安装、配置并启动mcollective和设置开机启动

```
node 'node.bw-y.com' {
  class { '::mcollective':
    middleware_hosts    => 'mq.host.com',
    middleware_port     => '61613',
    middleware_user     => 'username',
    middleware_password => 'password',
    plugin_psk          => 'psk',
    service_enable      => true,
    service_ensure      => 'running', 
  }
}
```

## Reference

### Classes

* mcollective:           : 主参数类
* mcollective::install   : 安装mcollective 
* mcollective::config    : 配置mcollective
* mcollective::service   : 管理mcollective服务状态

### Parameters

#### `server` and `client`
[可选项]这俩参数暂时无关联功能，后续会完善针对server端和client端的功能，目前不需要
#### `direct_addressing`
[可选项]mcollective的`direct_addressing`的配置,文档参考puppet官方文档. 默认值: '1'
#### `connector`
[可选项]mcollective使用的中间件,有效值[activemq|rabbitmq].  默认值: 'activemq'
#### `rabbitmq_vhost`
[可选项]当中间件使用rabbitmq时,需要设置`rabbitmq_vhost`. 默认值: '/mcollective'
#### `middleware_hosts`
[可选项]activemq主机所在ip或可正常解析的域名(目前暂不支持rabbitmq)   默认值：puppet.bw-y.com.cn
#### `middleware_port`
[可选项]activemq的服务端口(非ssl加密端口，暂不支持ssl)   默认值：61613
#### `middleware_user`
[可选项]activemq的用户名(设置activemq时在其配置文件指定)   默认值：mcollective
#### `middleware_password`
[可选项]activemq的密码(设置activemq时在其配置文件中指定)   默认值：pass
#### `plugin_psk`
[可选项]mcollective的配置项plugin.psk指定的密码字段  默认值：changeStr
#### `loglevel`
[可选项]mcollective server.cfg的日志级别,有效值(fatal, error , warn, info, debug)  默认值：info
#### `logfile`
[可选项]mcollective server.cfg的日志文件路径,有效值为一个有效文件路径即可，不推荐修改   默认值：/var/log/mcollective.log
#### `identity`
[可选项]当前节点以什么名称连接到mq,默认undef不设置则自动读取主机名; 在一些主机名大小写和自定义主机名场景,当此主机名和foreman页面的主机名无法匹配时,则页面会无法触发更新,因此,此项可以明确设置当前节点在mq中的名称,原则上,以foreman页面识别到的名称为准.
#### `service_enable`
[可选项]mcollective服务开机启动，有效值true(启动)/false(不启动)   默认值：true
#### `service_ensure`
[可选项]mcollective服务当前状态，有效值running/stopped    默认值：running
#### `stage`
[可选项]执行顺序，见stdlib::stages

## Limitations

```
1、支持系统： ubuntu(10.04/12.04/14.04)  rhel/centos(5/6)
```

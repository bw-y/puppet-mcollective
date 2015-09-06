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
这俩参数暂时无关联功能，后续会完善针对server端和client端的功能，目前不需要

#### `middleware_hosts`
activemq主机所在ip或可正常解析的域名(目前暂不支持rabbitmq)   默认值：puppet.bw-y.com

#### `middleware_port`
activemq的服务端口(非ssl加密端口，暂不支持ssl)   默认值：61613

#### `middleware_user`
activemq的用户名(设置activemq时在其配置文件指定)   默认值：mcollective

#### `middleware_password`
activemq的密码(设置activemq时在其配置文件中指定)   默认值：pass

#### `plugin_psk`
mcollective的配置项plugin.psk指定的密码字段  默认值：changeStr

#### `loglevel`
mcollective server.cfg的日志级别,有效值(fatal, error , warn, info, debug)  默认值：info

#### `logfile`
mcollective server.cfg的日志文件路径,有效值为一个有效文件路径即可，不推荐修改   默认值：/var/log/mcollective.log

#### `service_enable`
mcollective服务开机启动，有效值true(启动)/false(不启动)   默认值：true

#### `service_ensure`
mcollective服务当前状态，有效值running/stopped    默认值：running

## Limitations
```
支持系统： ubuntu12.04/14.04  rhel/centos5/6
```

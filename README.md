### 项目结构

```
.
├── Vagrantfile 
├── single                              #部署到dev/uat单服务的helm chart
│   ├── Chart.yaml
│   ├── charts
│   ├── templates
│   │   ├── NOTES.txt
│   │   ├── _helpers.tpl
│   │   ├── deployment.yaml
│   │   ├── ingress.yaml
│   │   └── service.yaml
│   └── values.yaml
├── coin                                 #整体部署到prod的helm chart
│   ├── Chart.yaml
│   ├── requirements.lock                #记录各个组件依赖的chart
│   ├── requirements.yaml
│   └── values.yaml
├── profile                              #各个模块使用到的values.yaml
│   ├── values.hasher.yaml
│   ├── values.redis.yaml
│   ├── values.rng.yaml
│   ├── values.webui.yaml
│   └── values.worker.yaml
├── clear-ns.sh                          #清空特定namespace下通过helm部署的资源
├── deploy-to-ns.sh                      #整体部署到dev/uat（包括redis）
├── deploy-to-prod.sh                    #整体部署到prod
├── install-prod-redis.sh                
├── install_traefik_controller.sh
└── namespace.sh


```



### 部署单个服务

#### 使用argument

```shell
helm install single --name=httpbin --namespace dev --set image.repository=kennethreitz/httpbin,ingress.enabled=true
```

#### 使用values.yaml

创建`value.your_name.yaml`，填写必要参数，例如

```yaml
app:
  name: redis
image:
  repository: redis
  port: 6379
service:
  port: 6379
ingress:
  enabled: false

```

执行

```shell
helm install single --name redis --namespace dev --values values.your_service.yaml
```



### 部署生产环境

```shell
#更新charts依赖
helm dep update coin
#部署到prod
helm install coin --namespace prod
```


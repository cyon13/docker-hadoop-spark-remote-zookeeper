# docker-hadoop-spark-remote-zookeeper

## 실행
### zookeeper 먼저 실행
[docker-zookeeper](https://github.com/cyon13/docker-zookeeper) 먼저 실행 후 kafka 실행
### docker-compose 실행

```sh
docker-compose up -d
```



### 처음 실행시 초기화
```sh
cluster-initialize.sh # 초기화
```


### 클러스터 실행/종료/재시작

```sh
#nn1 컨테이너에서 실행
cluster-start-all.sh #시작
cluster-stop-all.sh # 종료
cluster-restart-all.sh #재시작
```

### Web UI Port

- Namenode1 : 50070
- Namenode2 : 50071
- Spark: 18080
- Yarn : 8088

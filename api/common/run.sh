#!/usr/bin/env bash

#set -x
trap 'cd ../;' SIGINT

# 应用名称
app_name='backend'
# 包命名规则 - 开发阶段: sms-platform-dev-201222_1326
project_dir="/Users/ai/work/sms-platform/api/"
project_name='sms-platform'                 # 编译生成的应用程序名称
remote_dir='/data/www/sms.pusta.click'      # 远程部署目录
remote_user='ubuntu'                        # 远程用户
remote_host='TJ_TEST'                       # 远程主机
remote_key_file='~/.ssh/test.tianji.pem'    # 连接远程主机的key文件
remote_args=''                              # 远程需要执行的额外参数
app_version="2.0"
if [[ "$SPORT_VERSION" != "" ]]; then
    app_version="${SPORT_VERSION}"
fi

# 本地运行 - 位于src目录执行
run_local() {
    if [[ -e ~/go/bin/realize ]]; then
        ~/go/bin/realize start
    elif [[ -e ~/.go/bin/realize ]]; then
        ~/.go/bin/realize start
    else
        echo "缺少文件: realize"
    fi
}

# 上传到运端服务器文件
upload_file() {
    scp -i $remote_key_file $1 $2
}

# 运行远端命令
remote_cmd() {
    ssh -i $remote_key_file $1
}

# 远程部署 - 位于src目录执行
run_deploy() {
    echo "|->>> 当前目录: $PWD"
    echo "|->>> 远程主机: ${remote_user}@${remote_host} (${remote_key_file})"

    project_name="${app_name}-${app_version}" # 程序名称
    deploy_dir="${remote_dir}" # 程序部署目录 - 远程服务器上
    build_version="`date '+%y%m%d_%H%M'`"
    ###########################################################################
    # 1. 创建目录
    if [[ ! -d target ]]; then
        echo "|-> 创建目录: target"
        mkdir target
    fi
    temp_dir="target/${project_name}-compiled-${build_version}"
    if [[ -d $temp_dir ]]; then
        echo "|-> 删除之前存在的目录: $temp_dir ..."
        rm -rf $temp_dir
    fi
    echo "|-> 创建临时目录: $temp_dir ..."
    mkdir $temp_dir

    echo "|-> 进入目录: ./src"
    current_project_dir="${project_dir}/${app_name}"
    cd $current_project_dir/src

    echo "|-> 检查三方依赖 ..."
    go mod tidy
    if [[ "$?" != "0" ]]; then
        exit
    fi

    ###########################################################################
    # 2. 编译程序 - 上传程序
    echo "|-> 编译程序 ..."
    temp_bin="${project_name}-dev-${build_version}"
    # 判断是否是Mac系统/android, 此时需要交叉编译
    if [[ "`uname`" == "Darwin" || "`uname -a | grep -v grep | grep Android`" != "" ]]; then
        CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ../$temp_dir/$temp_bin  main.go
    else
        go build -o ../$temp_dir/$temp_bin  main.go # 编译程序
    fi
    if [[ "$?" != "0" ]]; then
        echo "|-> 编译程序失败"
        exit
    fi
    echo "|-> 上传二进制程序至远程服务器 ..."
    cd ../${temp_dir}
    remote_bin="${project_name}-dev-${build_version}"
    upload_file $temp_bin ${remote_user}@${remote_host}:${deploy_dir}/${app_name}/${remote_bin}

    ###########################################################################
    echo "|-> 远程服务器重启成功,  请删除临时目录: $temp_dir ..."
    cd ..
}

# 停止服务
stop_service() {
    project_name="sports-${app_name}" # 程序名称
    deploy_dir="${remote_dir}/${app_name}" # 程序部署目录 - 远程服务器上
    ssh -i $remote_key_file ${remote_user}@${remote_host} 2>1 << COMMAND
        cd ${deploy_dir}
        ps aux | grep -v grep | grep ${project_name} | awk '{ print $2 }' | xargs kill -9
        exit
COMMAND
}

# 重启服务 - 等同于启动服务
restart_service() {
    project_name="sports-${app_name}" # 程序名称
    deploy_dir="${remote_dir}/${app_name}" # 程序部署目录 - 远程服务器上
    bin_log="${project_name}-bin.log" # 日志文件名称
    ssh -i $remote_key_file ${remote_user}@${remote_host} 2>1 << COMMAND
        cd ${deploy_dir}
        ./restart.sh
        exit
COMMAND
}

# 清理所有的文件
clean_target() {
    if [[ ! -d ./target ]]; then
        echo "缺少目录： ./target"
        return
    fi
    count=0
    echo "删除 target 目录下生成文件"
    for d in `ls ./target`; do
        full_path="./target/${d}"
        echo "cleaning directory: $full_path"
        rm -rf $full_path
        ((count=$count+1))
    done
    echo "删除 src/sms-*相关文件"
    if [[ -d ./src ]]; then
        for d in `ls ./src/sms-*`; do
            if [[ -f $d ]]; then
                echo "删除可执行文件: $d"
                rm -rf $d
                ((count=$count+1))
            fi
        done
    fi
    echo "deleted total directories: $count"
}

# 启动服务
start_service() {
    restart_service
}

# 显示帮助信息
show_help() {
    echo "用法: ./run.sh dev|deploy|start|stop|restart|clean [prod] [admin]"
    echo "参数: "
    echo "      dev:        开发模式"
    echo "      deploy:     部署到远程开发服务器"
    echo "      start:      启动服务"
    echo "      stop:       停止服务"
    echo "      restart:    重启服务"
    exit
}

# 主函数
main() {

    # 操作说明 - 仅限已经指定命令
    if [[ "$1" != "dev" && "$1" != "deploy" && "$1" != "restart" && "$1" != "start" && "$1" != "clean" && "$1" != "stop" ]]; then
        echo "错误: 参数有误!"
        show_help
    fi

    if [[ "$1" == "clean" ]]; then
        clean_target
        exit
    fi

    # 生产环境还是测试环境
    if [[ "$2" == "prod" ]]; then
        remote_user="centos"
        remote_host="prod"
        remote_key_file="~/.ssh/PE_PROD.pem"
    fi

    app_name=`basename ${PWD}`
    # 命令参数 - 仅限已经指定参数
    if [[ "$app_name" != "admin-api" && "$app_name" != "crontab" && "$app_name" != "merchant-api" ]]; then
        echo "错误: 必须指定有效应用名称, 当前: [${app_name}] !"
        show_help
    fi

    # 检测环境、进入运行目录
    echo "*** 当前目录: $app_name ($PWD)"
    echo "*** 当前时间: `date '+%Y-%m-%d_%H:%M:%S'` ***"

    # 参数检测
    if [[ "$1" == "dev" ]]; then
        cd src
        run_local
    elif [[ "$1" == "deploy" ]]; then
        echo "*** 正向 *测试环境* 发布 ......"
        run_deploy
    elif [[ "$1" == "start" ]]; then
        start_service
        [[ "$2" == "prod" ]] && remote_host="prod2" && start_service
    elif [[ "$1" == "stop" ]]; then
        stop_service
        [[ "$2" == "prod" ]] && remote_host="prod2" && stop_service
    elif [[ "$1" == "restart" ]]; then
        restart_service
        [[ "$2" == "prod" ]] && remote_host="prod2" && restart_service
    else
        echo "-*- 错误 -*-"
    fi
}

# 用法: ./start.sh dev|deploy|release
main $@

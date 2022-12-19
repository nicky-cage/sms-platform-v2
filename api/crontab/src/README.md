# integrated-game-cron

游戏定时任务

#执行消息记录的消费进程
go run main.go -consumerName=user_wager
./integrated-game-cron -consumerName=user_wager &

#执行消息记录的报表进程
go run main.go -consumerName=user_report

./integrated-game-cron -consumerName=user_report &
./integrated-game-cron -consumerName=user_rebate &
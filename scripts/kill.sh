if [ $# != 1 ]; then
  echo -e "Usage:\t$0 <process_name_to_kill>\n"
  exit 1
fi

ps -eo pid:1,args | grep $1 | grep -v $0 | cut -d" " -f1 | xargs kill -9 >/dev/null 2>&1

exit 0

#!/bin/sh

if ps -e | grep -q sendmail-mta
   then result="true"
   else result="false"
fi

case "${result}" in
"true")
   echo "$(date)\tINFORMATION: Service sendmail is running" | sudo tee -a /var/log/sendmail.log
;;

"false")
   echo "$(date)\tWARNING: Service sendmail has been stopped. Attempting to start service again" | sudo tee -a /var/log/sendmail.log
   sudo service sendmail start
   if ps -e | grep -q sendmail-mta
      then echo "$(date)\tRECOVERY: Service sendmail successfully started again" | sudo tee -a /var/log/sendmail.log
      else echo "$(date)\tCRITICAL: Failed to recover service sendmail. Reporting this to driftlarm@donator.se" | sudo tee -a /var/log/sendmail.log
( 
sleep 1 
echo "EHLO don-mailgate-web01" 
sleep 1 
echo "MAIL FROM: admin@don-mailgate-web01" 
sleep 1 
echo "RCPT TO: driftlarm@donator.se" 
sleep 1 
echo "DATA" 
sleep 1 
echo "Subject:CRITICAL: Service sendmail is DOWN on don-mailgate-web01. Details: /var/log/sendmail.log" 
sleep 1 
echo "FROM: <admin@don-mailgate-web01>" 
sleep 1 
echo "TO: driftlarm@donator.se" 
sleep 1
echo "." 
sleep 1 
echo "QUIT" 
) | telnet 10.99.195.14 25
   fi
;;
esac
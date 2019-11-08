while true; 
    do /sbin/ifconfig en1 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/ .*//'; 
    sleep 2s; 
done;
for file in $(ls /kvmnt/)
do
    var_value=$(cat /kvmnt/$file)
    var_name=`echo $file | sed "s/-/_/g"`
    echo "$var_name=$var_value" >> /home/node/app/.env
done
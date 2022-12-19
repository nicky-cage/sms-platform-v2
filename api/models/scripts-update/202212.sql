-- 导出相关商户信息

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10010 INTO OUTFILE '/Users/ai/work/data/10010.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10011 INTO OUTFILE '/Users/ai/work/data/10011.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S') 
    from messages 
    where merchant_id = 10012 INTO OUTFILE '/Users/ai/work/data/10012.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10013 INTO OUTFILE '/Users/ai/work/data/10013.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10014 INTO OUTFILE '/Users/ai/work/data/10014.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10016 INTO OUTFILE '/Users/ai/work/data/10016.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10018 INTO OUTFILE '/Users/ai/work/data/10018.txt';

select merchant_name, phone_prefix, phone, phone_full, message_id, content, FROM_UNIXTIME(created / 1000000, '%Y-%m-%d %H:%I:%S')
    from messages 
    where merchant_id = 10019 INTO OUTFILE '/Users/ai/work/data/10019.txt';
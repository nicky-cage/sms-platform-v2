truncate admin_login_logs;
alter table admin_login_logs auto_increment = 100000;

truncate admin_logs;
alter table admin_logs auto_increment = 100000;

truncate merchants;
alter table merchants auto_increment = 10000;

truncate merchant_accounts;
alter table merchant_accounts auto_increment = 10000;

truncate merchant_apps;
alter table merchant_apps auto_increment = 100000;

truncate merchant_app_logs;
alter table merchant_app_logs auto_increment = 100000;

truncate merchant_login_logs;
alter table merchant_login_logs auto_increment = 100000;

truncate merchant_logs;
alter table merchant_logs auto_increment = 100000;

truncate country_rates;
alter table country_rates auto_increment = 100000;

truncate message_batches;
alter table message_batches auto_increment = 100000;

truncate message_channels;
alter table message_channels auto_increment = 1000;

truncate message_templates;
alter table message_templates auto_increment = 100000;

truncate messages;
alter table messages auto_increment = 100000;

truncate parameter_groups;
alter table parameter_groups auto_increment = 100000;

truncate parameters;
alter table parameters auto_increment = 100000;

truncate permission_ips;
alter table permission_ips auto_increment = 100000;

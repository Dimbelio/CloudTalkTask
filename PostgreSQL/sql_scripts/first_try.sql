insert into ps_aors (id, max_contacts) values ('0000f30A0A01', 1);
insert into ps_aors (id, max_contacts) values ('0000f30B0B02', 1);
insert
into ps_auths
(id, auth_type, password, username)
values
('0000f30A0A01', 'userpass', 'not very secure', '0000f30A0A01');
insert
into ps_auths
(id, auth_type, password, username)
values
('0000f30B0B02', 'userpass', 'hardly to be trusted', '0000f30B0B02');
insert
into ps_endpoints
(id, transport, aors, auth, context, disallow, allow, direct_media)
values
('0000f30A0A01', 'transport-udp', '0000f30A0A01', '0000f30A0A01',
'sets', 'all', 'ulaw', 'no');
insert
into ps_endpoints
(id, transport, aors, auth, context, disallow, allow, direct_media)
values
('0000f30B0B02', 'transport-udp', '0000f30B0B02', '0000f30B0B02',
'sets', 'all', 'ulaw', 'no');
exit
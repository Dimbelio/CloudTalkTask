-- Variables for the user
\set USERNAME 'sipp-test'
\set PASSWORD 'secret'
\set CONTEXT 'default'
\set TRANSPORT 'transport-udp'

-- Insert into ps_auths
INSERT INTO ps_auths (id, auth_type, username, password)
VALUES (:'USERNAME', 'userpass', :'USERNAME', :'PASSWORD');

-- Insert into ps_aors
INSERT INTO ps_aors (id, max_contacts, remove_existing)
VALUES (:'USERNAME', 1, 'yes');

-- Insert into ps_endpoints
INSERT INTO ps_endpoints (
    id, transport, aors, auth, context, disallow, allow,
    direct_media, force_rport, rewrite_contact, rtp_symmetric
)
VALUES (:'USERNAME', :'TRANSPORT', :'USERNAME', :'USERNAME', :'CONTEXT','all', 'ulaw', 'no', 'yes', 'yes', 'yes');
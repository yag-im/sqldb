/*
INSERT INTO cluster.jukebox_nodes(hostname, private_ip, public_ip, region, node_type, flavor, dgpu, igpu)
VALUES (
    'host.docker.internal',
    '172.17.0.1',
    '172.17.0.1',
    'us-west-1',
    'dedicated',
    'RISE-3',
    NULL,
    'intel');
*/

INSERT INTO cluster.jukebox_nodes(hostname, private_ip, public_ip, region, node_type, flavor, dgpu, igpu)
VALUES (
   'jukebox1.us-east-1.yag.im',
   '192.168.12.2',
   '135.148.169.16',
   'us-east-1',
   'dedicated',
   'RISE-3',
   NULL,
   'intel');

INSERT INTO cluster.jukebox_nodes(hostname, private_ip, public_ip, region, node_type, flavor, dgpu, igpu)
VALUES (
   'jukebox1.us-west-1.yag.im',
   '192.168.13.2',
   '51.81.208.83',
   'us-west-1',
   'dedicated',
   'RISE-3',
   NULL,
   'intel');

INSERT INTO cluster.appstor_nodes(hostname, private_ip, region, node_type, flavor, share_id)
VALUES (
    'appstor1.us-east-1.yag.im',
    '192.168.12.200',
    'us-east-1',
    'public-cloud-instance',
    'b3-8',
    0
);

INSERT INTO cluster.appstor_nodes(hostname, private_ip, region, node_type, flavor, share_id)
VALUES (
   'appstor1.us-west-1.yag.im',
   '192.168.13.200',
   'us-west-1',
   'public-cloud-instance',
   'b3-8',
   0
);

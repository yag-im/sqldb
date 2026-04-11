/*
INSERT INTO cluster.jukebox_nodes(uuid, private_ip, public_ip, region, node_type, flavor, dgpu, igpu)
VALUES (
    'f973b9a3-2d9b-4168-bbff-a9fa1d1bc5dc',
    '172.17.0.1',
    '172.17.0.1',
    'us-west-1',
    'dedicated',
    'rise-3',
    NULL,
    'intel');
*/

INSERT INTO cluster.jukebox_nodes(uuid, private_ip, public_ip, region, node_type, flavor, dgpu, igpu)
VALUES (
   'd77f5742-b554-4374-8262-29512d68b684',
   '192.168.12.2',
   '135.148.169.16',
   'us-east-1',
   'dedicated',
   'rise-3',
   NULL,
   'intel');

INSERT INTO cluster.jukebox_nodes(uuid, private_ip, public_ip, region, node_type, flavor, dgpu, igpu)
VALUES (
   'ed9bd877-1337-4158-bad7-f97aecfce9e6',
   '192.168.13.2',
   '51.81.208.83',
   'us-west-1',
   'dedicated',
   'rise-3',
   NULL,
   'intel');

INSERT INTO cluster.appstor_nodes(uuid, private_ip, region, node_type, flavor, share_id)
VALUES (
    'b5157279-85ee-4d11-9399-8ab23a1baee3',
    '192.168.12.200',
    'us-east-1',
    'public-cloud-instance',
    'b3-8',
    0
);

INSERT INTO cluster.appstor_nodes(uuid, private_ip, region, node_type, flavor, share_id)
VALUES (
   '2a5c4e38-b969-495a-9149-cd632af65039',
   '192.168.13.200',
   'us-west-1',
   'public-cloud-instance',
   'b3-8',
   0
);

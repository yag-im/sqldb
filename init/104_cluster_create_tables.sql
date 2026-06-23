\c yag;

-- normalized region names (dedicated and cloud instances use different region names in OVH)
CREATE TYPE cluster.region AS ENUM ('us-west-1', 'us-east-1');
CREATE TYPE cluster.node_type AS ENUM ('dedicated', 'public-cloud-instance');
CREATE TYPE cluster.node_flavor AS ENUM ('rise-3', 'b3-7', 'b3-8', 't2-le-45', 'l4-90');
CREATE TYPE cluster.service_type AS ENUM ('jukebox', 'appstor');

CREATE TABLE cluster.nodes
(
    id               BIGSERIAL PRIMARY KEY NOT NULL,
    uuid             UUID UNIQUE NOT NULL,
    region           cluster.region NOT NULL,
    service_type     cluster.service_type NOT NULL,
    node_ix          SMALLINT NOT NULL,
    node_type        cluster.node_type NOT NULL,
    node_flavor      cluster.node_flavor NOT NULL,
    created_ts       TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE UNIQUE INDEX cluster_nodes_uidx ON cluster.nodes (region, service_type, node_ix);

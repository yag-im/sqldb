\c yag;

-- normalized region names (dedicated and cloud instances use different region names in OVH)
CREATE TYPE cluster.region AS ENUM ('us-west-1', 'us-east-1');
CREATE TYPE cluster.node_type AS ENUM ('dedicated', 'public-cloud-instance');
CREATE TYPE cluster.node_flavor AS ENUM ('rise-3', 'b3-7', 'b3-8', 't2-le-45', 'l4-90');

CREATE TABLE cluster.appstor_nodes
(
    id               BIGSERIAL PRIMARY KEY NOT NULL,
    uuid             UUID UNIQUE NOT NULL,
    private_ip       INET UNIQUE NOT NULL,
    region           cluster.region NOT NULL,
    node_type        cluster.node_type NOT NULL,
    flavor           cluster.node_flavor NOT NULL,
    created_ts       TIMESTAMP NOT NULL DEFAULT NOW(),
    share_id         SMALLINT NOT NULL
);

CREATE TABLE cluster.jukebox_nodes
(
    id               BIGSERIAL PRIMARY KEY NOT NULL,
    uuid             UUID UNIQUE NOT NULL,
    private_ip       INET UNIQUE NOT NULL,
    public_ip        INET UNIQUE NOT NULL,
    region           cluster.region NOT NULL,
    node_type        cluster.node_type NOT NULL,
    flavor           cluster.node_flavor NOT NULL,
    created_ts       TIMESTAMP NOT NULL DEFAULT NOW()
);

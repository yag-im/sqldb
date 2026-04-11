\c yag;

CREATE TYPE cluster.region AS ENUM ('us-west-1', 'us-east-1');
CREATE TYPE cluster.dgpu_type AS ENUM ('nvidia', 'intel');
CREATE TYPE cluster.igpu_type AS ENUM ('intel', 'amd');
CREATE TYPE cluster.node_type AS ENUM ('dedicated', 'public-cloud-instance');
CREATE TYPE cluster.node_flavor AS ENUM ('rise-3', 'b3-8', 't2-le-45');

CREATE TABLE cluster.appstor_nodes
(
    id               BIGSERIAL PRIMARY KEY NOT NULL,
    uuid             UUID UNIQUE NOT NULL,
    private_ip       INET UNIQUE NOT NULL,
    region           cluster.region NOT NULL,
    node_type        cluster.node_type NOT NULL,
    flavor           cluster.node_flavor NOT NULL,
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
    dgpu             cluster.dgpu_type NULL,
    igpu             cluster.igpu_type NULL
);

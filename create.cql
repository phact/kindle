 create KEYSPACE kindle WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1}

CREATE TABLE kindle.highlights (
	id text,
	highlight text,
	asin text,
	title text,
	author text,
	primary key (id)
)
WITH comment = 'Highlights for all the books Ive read on Amazon';

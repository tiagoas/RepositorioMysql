use curso;
-- myisam
CHECK TABLE senso QUICK;

REPAIR TABLE senso quick;

ANALYZE TABLE senso;

OPTIMIZE TABLE senso;
-- innodb
CHECK TABLE campeonato QUICK;

REPAIR TABLE campeonato quick;

ANALYZE TABLE campeonato;

OPTIMIZE TABLE campeonato;
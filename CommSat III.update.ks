// ComSat III Update v 1.0
// Wayne Crawford

COPY CommSat.circularize.ks from 0.

WAIT 1.

RUN CommSat.circularize.ks(500000, "CommSat II, 10).

WAIT 1.

DELETE CommSat.circularize.ks.
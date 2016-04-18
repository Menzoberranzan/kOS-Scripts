// CommSat II Mission v 1.0
// Menzoberranzan

copy CommSat.circularize.ks from 0.
copy launch.ks from 0.
copy CommSat.startup.ks from 0.
rename CommSat.startup.ks to startup.ks.

run launch.ks.

set p to ship:partstitled("Communotron 16")[0].
set m to p:getmodule("ModuleRTAntenna").
m:doevent("activate").

wait 1.
delete launch.ks.
wait 1.
run CommSat.circularize.ks(2868750, "CommSat II", 0).
wait 1.
delete CommSat.circularize.ks.

toggle panels.

set p to ship:partstitled("Reflectron KR-7")[0].
set m to p:getmodule("ModuleRTAntenna").
m:doevent("activate").
m:setfield("target", "Mun").

set p to ship:partstitled("Reflectron KR-7")[1].
set m to p:getmodule("ModuleRTAntenna").
m:doevent("activate").
m:setfield("target", "Minmus").

set p to ship:partstitled("Reflectron KR-7")[2].
set m to p:getmodule("ModuleRTAntenna").
m:doevent("activate").
m:setfield("target", "Active Vessel").
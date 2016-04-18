// CommSat.startup.ks v1.0
// Menzoberranzan

if ship:electriccharge < 200 {
  TOGGLE BRAKES. // Disable dish
}

if ship:electriccharge > 800 {
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
}

wait 10.
reboot
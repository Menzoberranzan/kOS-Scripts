// Launch v.2 -- Launch a ship to a speciffic orbit
// Usage:
//   run launch(<alt>).
//
// Version History:
//   2.0.1: Initial draft

// Variables:

declare parameter targetAltitude.
declare statusMsg.
set maneuverComplete to False.

// Set up staging when we're off the ground

when altitude > 100 then {
  set statusMsg to "Launch complete, throttle to 90%".
  lock throttle to 0.9.
  when maxthrust = 0 then {
    stage.
    preserve.
  }
}

// Set up altitude-triggers (grav turn etc)

when altitude > 10000 then {
  sas off.
  set statusMsg to "Gravity turn. Throttle up.".
  lock steering to heading(90,45).
  lock throttle to 1.
  when apoapsis > 40000 then {
    // Start the gravity turn
    set statusMsg to "Burning to target Ap.".
    lock steering to heading(90,0).
    when apoapsis > targetAltitude*1000 then {
      // Coast to apoapsis and prepare maneuver-node
      set statusMsg to "Burn complete. Coasting to target Ap.".
      lock throttle to 0.
      set orbitBody to body("Kerbin").
      set deltaA to maxthrust/mass.
      set orbitalVelocity to orbitBody:radius * sqrt(9.8/(orbitBody:radius + (targetAltitude*1000))).
      set deltaV to (orbitalVelocity - velocity:orbit:mag).
      set timeToBurn to deltaV/deltaA.
      set circNode to node(time:seconds + eta:apoapsis,0,0,deltaV).
      add circNode.
      set burnTo to circNode:burnvector.
      lock steering to burnTo.
      when circNode:eta < timeToBurn/2 then {
        set statusMsg to "Circularizing. V=" + round(orbitalVelocity) + "m/s, T=" + timeToBurn + "s.".
        lock throttle to 1.
        when velocity:orbit:mag > orbitalVelocity then {
          set statusMsg to "Circularization complete. Shutting down.".
          lock throttle to 0.
          unlock steering.
          sas on.
          panels on.
          set maneuverComplete to True.
        }
      }
    }
  }
}

// Setup static display elements.

clearscreen.
print "+------------------------------------------------+".
print "|                                   kOS v.       |".
print "+------------------------------------------------+".
print "| Orbit parameters:                              |".
print "+------------------------------------------------+".
print "| Ap :                  Pe :                     |".
print "| Inc:                  Ecc:                     |".
print "+------------------------------------------------+".
print "| Status:                                        |".
print "+------------------------------------------------+".
print "|                                                |".
print "|                                                |".
print "+------------------------------------------------+".
print SHIP:NAME at (2,1).
print VERSION at (42,1).

// Prepare for launch

set statusMsg to "Launching.".
lock throttle to 1.
sas on. 
rcs on. 
wait 3. 

// Launch!!

stage.

// Main loop

until maneuverComplete {
  set lastUpdate to time.
  print round(apoapsis/1000,2) + "km     " at (7,5).
  print round(periapsis/1000,2) + "km     " at (29,5).
  print round(ship:obt:inclination, 2) + "     " at (7,6).
  print round(ship:obt:eccentricity, 2) + "     " at (29,6).
  print "                                                " at(1,10).
  print "                                                " at(1,11).
  print statusMsg at (2,10).
  print "<" + status + ">" at (2,11).
  wait until time > lastUpdate.  // Wait for physics tick to avoid flicker.
}

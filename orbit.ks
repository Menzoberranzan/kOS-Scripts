FUNCTION LNG_TO_DEGREES {
  PARAMETER lng.

  RETURN MOD(lng + 360, 360).
}

FUNCTION ORBITABLE {
  PARAMETER name.

  LIST TARGETS in vessels.
  FOR vs IN vessels {
    IF vs:NAME = name {
      RETURN VESSEL(name).
    }
  }

  RETURN BODY(name).
}

FUNCTION TARGET_ANGLE {
  PARAMETER target.

  RETURN MOD(
    LNG_TO_DEGREES(ORBITABLE(target):LONGITUDE)
    - LNG_TO_DEGREES(SHIP:LONGITUDE) + 360,
    360
  ).
}